//
//  BaseApi.swift
//  social
//
//  Created by Ahmed Ragab on 6/26/20.
//  Copyright © 2020 Ahmed Ragab. All rights reserved.
//

import Foundation
import Alamofire


class BaseApi<T:TargetType> {
    func fetchData<M:Decodable>(target:T,responceClass:M.Type,completion:@escaping(Result<M?,NSError>)->Void){
        
        let method = Alamofire.HTTPMethod(rawValue: target.method.rawValue)
        let headers = HTTPHeaders(target.headers ?? [:])
        let params = buildParams(task: target.task)
        
        AF.request(target.baseUrl+target.path,method: method,parameters: params.0,encoding: params.1,headers:headers,interceptor: CustomInterceptor())
            .validate(statusCode:200...300)
            .responseJSON { (responce) in
                guard let statusCode = responce.response?.statusCode else {
                    
                    // errors
                    completion(.failure(NSError()))
                    return
                }
                if statusCode == 200{
                    
                    guard let jsonResponce  = try? responce.result.get() else {
                        //error
                        print("error in serialize")
                        completion(.failure(NSError()))
                        return
                    }
                    guard let jsonData = try? JSONSerialization.data(withJSONObject: jsonResponce, options: []) else{
                        // error
                        print("error in data")
                        completion(.failure(NSError()))
                        return
                    }
                    let decoder = JSONDecoder()
                    decoder.dataDecodingStrategy = .base64
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    do{
                     let jsonObject = try? decoder.decode(M.self, from: jsonData)
                        //error
                      print(jsonObject)
                      completion(.success(jsonObject))
                      
                        }catch(let error){
                            print(error)
                        }
                }else{
                    // error
                print("staus code error")
                    if (statusCode==401){
                       // UserDefaults.standard.removeObject(forKey: "token")
                        print("401 error unauthoraized")
                        completion(.failure(NSError()))
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


