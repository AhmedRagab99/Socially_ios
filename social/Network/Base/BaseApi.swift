//
//  BaseApi.swift
//  social
//
//  Created by Ahmed Ragab on 6/26/20.
//  Copyright © 2020 Ahmed Ragab. All rights reserved.
//

import Foundation
import Alamofire
import SwiftUI


class BaseApi<T:TargetType> {
    func fetchData<M:Decodable>(target:T,responceClass:M.Type,completion:@escaping(Result<M?,ApiError>)->Void){
        
        let method = Alamofire.HTTPMethod(rawValue: target.method.rawValue)
        let headers = HTTPHeaders(target.headers ?? [:])
        let params = buildParams(task: target.task)
        
        AF.request(target.baseUrl+target.path,method: method,parameters: params.0,encoding: params.1,headers:headers,interceptor: CustomInterceptor())
            .validate(statusCode:200...310)
            .responseJSON { (responce) in
                guard let statusCode = responce.response?.statusCode else {
                    
                    // errors
                    completion(.failure(.apiError))
                    return
                }
                if statusCode == 200{
                    
                    guard let jsonResponce  = try? responce.result.get() else {
                        //error
                        print("error in serialize")
                        completion(.failure(.invalidEndpoint))
                        return
                    }
                    guard let jsonData = try? JSONSerialization.data(withJSONObject: jsonResponce, options: []) else{
                        // error
                        print("error in data")
                        completion(.failure(.noData))
                        return
                    }
                    let decoder = JSONDecoder()
                    decoder.dataDecodingStrategy = .base64
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    do{
                        let jsonObject = try decoder.decode(M.self, from: jsonData)
                        //error
                        //print(jsonObject)
                        completion(.success(jsonObject))
                        
                    }catch(let error){
                        completion(.failure(.invalidResponse))
                        print(error.localizedDescription)
                    }
                }else{
                    // error
                    print("staus code error")
                    if (statusCode==401){
                        // UserDefaults.standard.removeObject(forKey: "token")
                        helper.deleteApiToken()
                        helper.goSignIn()
                        // print("401 error unauthoraized")
                        completion(.failure(.AuthError))
                    }
                    else  if statusCode == 422 && ((responce.request?.url?.absoluteString.contains("/auth")) != nil){
                        completion(.failure(.invalidResponse))
                    }
                    else  if statusCode == 422{
                        completion(.failure(.noData))
                    }
                    else {
                        completion(.failure(.invalidResponse))
                    }
                    
                }
        }
    }
    
    fileprivate func buildParams(task:Task)->([String:Any],ParameterEncoding){
        switch task{
            
        case .requestPlain:
            return ([:],URLEncoding.default)
        case .requestParameters(parameters: let parameters, encoding: let encoding):
            return (parameters,encoding)
        }
        
    }
}


