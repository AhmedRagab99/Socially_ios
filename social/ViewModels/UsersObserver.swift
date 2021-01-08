//
//  UsersObserver.swift
//  social
//
//  Created by Ahmed Ragab on 7/9/20.
//  Copyright © 2020 Ahmed Ragab. All rights reserved.
//

import Foundation
import Alamofire


class UserObserver:ObservableObject{
    @Published var allUser = [User]()
    @Published var singleUserData = ProfileModel()
    @Published var userFollow = User()
    @Published var userUnFollow = User()
    
    
    @Published var isError = false
    @Published var error = ""
    @Published var isLoading = false
    
    
    
    
    
    func unFollowUser(unfollowId:String){
         UserApi.shared.unFollowUser(unfollowId: unfollowId) { (result) in
            self.isLoading = true
            switch result{
            case .success(let responce):
                guard let data = responce else {return}
                DispatchQueue.main.async {
                    self.userUnFollow = data
                    self.isLoading.toggle()
                }
            case .failure(let error):
                self.isError.toggle()
                self.isLoading=false
                self.error = error.localizedDescription
            }
        }
     }
    
    
    
    func followUser(followId:String){
        UserApi.shared.followUser(followId: followId) { (result) in
            self.isLoading = true
            switch result{
            case .success(let responce):
                guard let data = responce else {return}
                DispatchQueue.main.async {
                    self.userFollow = data
                    self.isLoading.toggle()
                }
            case .failure(let error):
                self.isError.toggle()
                self.isLoading=false
                self.error = error.localizedDescription
            }
        }
    }
    
    
    
    
    func getUser(userId:String){
        UserApi.shared.getUser(userId: userId) { (result) in
            self.isLoading = true
            switch result{
            case .success(let responce):
                guard let data = responce else {return}
                DispatchQueue.main.async {
                
                    self.singleUserData = data
                    self.isLoading.toggle()
                }
                
            case .failure(let error):
                self.isError.toggle()
                self.isLoading=false
                self.error = error.localizedDescription
            }
        }
    }
    
    func getAllUsers(){
        UserApi.shared.allUsers { (result) in
            self.isLoading = true
            switch result{
            case .success(let responce):
                guard let data = responce else {return}
                DispatchQueue.main.async {
                    self.allUser = data
                    self.isLoading.toggle()
                }
            case .failure(let error):
                self.isError.toggle()
                self.isLoading=false
                self.error = error.localizedDescription
            }
        }
    }
}
