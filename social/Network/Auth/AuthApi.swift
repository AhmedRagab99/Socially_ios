//
//  AuthApi.swift
//  social
//
//  Created by Ahmed Ragab on 6/27/20.
//  Copyright © 2020 Ahmed Ragab. All rights reserved.
//

import Foundation
import Alamofire

class AuthApi:BaseApi<AuthNetworking>{
    
    
    static let shared = AuthApi()
    
    
   private override init() {
        
    }
    
    
    
    func signIn(email:String,password:String,completion:@escaping (Result<UserModel?,NSError>)->Void){
        self.fetchData(target: .singIn(email: email, password: password), responceClass: UserModel.self) { (result) in
            completion(result)
        }
    }
    
    
    
    func signUp(email:String,name:String,picuture:String,password:String,completion:@escaping (Result<Message?,NSError>)->Void){
        self.fetchData(target: .signUp(name: name, email: email, piciture: picuture, password: password), responceClass: Message.self) { (result) in
            completion(result)
        }
    }
    
}
