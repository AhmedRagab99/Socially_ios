//
//  helper.swift
//  social
//
//  Created by Ahmed Ragab on 7/5/20.
//  Copyright © 2020 Ahmed Ragab. All rights reserved.
//

import SwiftUI

class helper:NSObject{
    
    class func goHome() {
           if let window = UIApplication.shared.windows.first {
               window.rootViewController = UIHostingController(rootView: TabBar().animation(.easeInOut(duration: 0.7)))
               window.makeKeyAndVisible()
           }
       }
    
    class func goSignIn() {
             if let window = UIApplication.shared.windows.first {
                 window.rootViewController = UIHostingController(rootView: LoginView().animation(.easeInOut(duration: 0.7)))
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
        UserDefaults.standard.removeObject(forKey: "token")
       }
    
    class func getApiToken() -> String? {
        let def = UserDefaults.standard
        return def.object(forKey: "token") as? String
    }
}
