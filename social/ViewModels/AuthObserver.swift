//
//  AuthObserver.swift
//  social
//
//  Created by Ahmed Ragab on 7/4/20.
//  Copyright © 2020 Ahmed Ragab. All rights reserved.
//

import Foundation
import Alamofire
import SwiftUI



class AuthObserver:ObservableObject{
    
    
    // @Published var signUpPuplisher = Message()
    @Published var signInPuplisher = UserModel()
    @Published var signUpPuplisher = Message()
    @Published var isLogIn = false
    @Published var isError = false
    @Published var isLoading = false
    @Published var error = ""
    @Published var isSignUn = false

    
    
    
    
    init() {
        
    }
    
    
    func signIn(email:String,password:String){
        AuthApi.shared.signIn(email: email, password: password) { [weak self] (result) in
            guard let self = self else {return}
            self.isLoading = true

            switch result{
                
            case .success(let responce ):
                print(responce ?? "")
                    self.isLogIn.toggle()
                
                self.isLoading.toggle()
                
                guard let data = responce else { return  }
                
                guard let token = data.token else {return}
                
                helper.saveApiToken(token: token)
                
                  UserDefaults.standard.setValue(data.user?.pic, forKeyPath: "userPic")
                   UserDefaults.standard.setValue(data.user?.id, forKeyPath: "userId")
                    UserDefaults.standard.setValue(data.user?.name, forKeyPath: "userName")
                UserDefaults.standard.setValue(data.user?.followers?.count, forKeyPath: "followers")
                UserDefaults.standard.setValue(data.user?.following?.count, forKeyPath: "following")
                 UserDefaults.standard.setValue(data.user?.pio, forKeyPath: "pio")
                
                self.signInPuplisher = data
                
                DispatchQueue.main.asyncAfter(deadline: .now()+2){
                helper.goHome()
                }
                
            case .failure(let error):
                self.isError.toggle()
                self.error = error.localizedDescription
                self.isLoading.toggle()
                print(error.localizedDescription)
            }
        }
    }
    
    func signUp(email:String,name:String,password:String,pic:String){
        AuthApi.shared.signUp(email: email, name: name, picuture: pic, password: password) { [weak self] (result) in
            guard let self = self else {return}
            self.isLoading = true

            switch result{
                
                
            case .success(let responce ):
                print(responce ?? "")
                self.isLoading.toggle()

                guard let responce  = responce else {return}
                DispatchQueue.main.async {
                    self.isSignUn = true
                    
                }
                self.signUpPuplisher = responce
               
            case .failure(let error):
                self.isError.toggle()
                self.error = error.localizedDescription
                self.isLoading.toggle()
                print(error.localizedDescription)
            }
        }
    }
    
    
}
