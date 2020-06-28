//
//  AuthNetworking.swift
//  social
//
//  Created by Ahmed Ragab on 6/27/20.
//  Copyright © 2020 Ahmed Ragab. All rights reserved.
//

import Foundation
import Alamofire


enum AuthNetworking{
    case signUp(name:String,email:String,piciture:String,password:String)
    case singIn(email:String,password:String)
}


extension AuthNetworking:TargetType{
    var baseUrl: String {
        return Constants.baseUrl
    }
    
    var path: String {
        switch self{
        case .signUp:
            return "/auth/signup"
        case .singIn:
            return "/auth/signin"
        }
    }
    
    var method: HTTPMethod {
        switch self{
        case .signUp,.singIn:
            return .post
            
        }
    }
    
    var task: Task {
    switch self{
        case .signUp(let name,let email, let piciture, let password):
            return .requestParameters(parameters: ["name":name,"email":email,"pic":piciture,"password":password], encoding:JSONEncoding.default )
            
        case .singIn(let email, let password):
            
            return .requestParameters(parameters: ["email":email,"password":password], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self{
        case .singIn,.signUp:
            return [:]
        }
    }
    
    
}
