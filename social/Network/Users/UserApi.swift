//
//  UserApi.swift
//  social
//
//  Created by Ahmed Ragab on 6/27/20.
//  Copyright © 2020 Ahmed Ragab. All rights reserved.
//


import Foundation
import Alamofire

class UserApi:BaseApi<UserNetworking>{
    
    
    static let shared = UserApi()
    
    
   private override init() {
        
    }
    
    
    func getUser(userId:String,completion:@escaping (Result<ProfileModel?,NSError>)->Void){
        self.fetchData(target: .getUser(userId: userId), responceClass: ProfileModel.self) { (result) in
            completion(result)
        }
    }
    
    func followUser(followId:String,completion:@escaping (Result<User?,NSError>)->Void){
        self.fetchData(target: .followUser(followId: followId), responceClass: User.self) { (result) in
               completion(result)
           }
       }
    
    func allUsers(completion:@escaping (Result<[User]?,NSError>)->Void){
        self.fetchData(target: .allUsers, responceClass: [User].self) { (result) in
                  completion(result)
              }
          }
    
    
    func unFollowUser(unfollowId:String,completion:@escaping (Result<User?,NSError>)->Void){
           self.fetchData(target: .unFollowUser(unfollowId: unfollowId), responceClass: User.self) { (result) in
                  completion(result)
              }
          }
    
  
}



