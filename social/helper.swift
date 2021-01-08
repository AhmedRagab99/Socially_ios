//
//  helper.swift
//  social
//
//  Created by Ahmed Ragab on 7/5/20.
//  Copyright © 2020 Ahmed Ragab. All rights reserved.
//

import SwiftUI



let userPic = UserDefaults.standard.object(forKey: "userPic")
let userId = UserDefaults.standard.object(forKey: "userId")
let userPio = UserDefaults.standard.object(forKey: "pio")
let userName = UserDefaults.standard.object(forKey: "userName")
let userFollowers = UserDefaults.standard.object(forKey: "followers")
let userFollowing = UserDefaults.standard.object(forKey: "following")


class helper:NSObject{
    
    
    
    
    
    class func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    class func goHome() {
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = UIHostingController(rootView: TabBar())
            window.makeKeyAndVisible()
            
        }
    }
    
    class func goSignIn() {
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = UIHostingController(rootView: LoginView())
            window.makeKeyAndVisible()
        }
    }
    
    class func goSignUp() {
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = UIHostingController(rootView: SignUpView())
            window.makeKeyAndVisible()
        }
    }
    
    class func restartApp()-> AnyView {
        
        if getApiToken() == nil {
            
            return AnyView(LoginView())
        } else {
            // go to main screen
            return AnyView(TabBar())
            
        }
        
    }
    
    class func saveApiToken(token: String) {
        // save api token to UserDefaults
        UserDefaults.standard.setValue("Bearer \(token)", forKeyPath: "token")
    }
    class func deleteApiToken(){
        // save api token to UserDefaults
//        let userPic = UserDefaults.standard.object(forKey: "userPic")
//        let userId = UserDefaults.standard.object(forKey: "userId")
//        let userPio = UserDefaults.standard.object(forKey: "pio")
//        let userFollowers = UserDefaults.standard.object(forKey: "followers")
//        let userFollowing = UserDefaults.standard.object(forKey: "following")
        UserDefaults.standard.removeObject(forKey: "token")
        UserDefaults.standard.removeObject(forKey: "userPic")
        UserDefaults.standard.removeObject(forKey: "userId")
        UserDefaults.standard.removeObject(forKey: "followers")
        UserDefaults.standard.removeObject(forKey: "following")
        UserDefaults.standard.removeObject(forKey: "pio")
        
    }
    
    class func getApiToken() -> String? {
        let def = UserDefaults.standard
        return def.object(forKey: "token") as? String
    }
    
    
  
}
