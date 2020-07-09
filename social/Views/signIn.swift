//
//  signIn.swift
//  social
//
//  Created by Ahmed Ragab on 7/5/20.
//  Copyright © 2020 Ahmed Ragab. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    
    @ObservedObject var Authbserver = AuthObserver()
    @ObservedObject var keyboardResponder = KeyboardResponder()
    
    @State private var email = ""
    @State private var password = ""
    @State private var showAlert = false
    @State private var isLoading = false
    @State private var showSignUp = false
    
    
    var body: some View {
        NavigationView {
  
            
            ZStack {
                if self.Authbserver.isLoading == true{
                    VStack{
                        LoadingView(isLoading:self.Authbserver.isLoading,retryAction: nil)
                    }
                }
                
                
                VStack(alignment: .center) {
                    Spacer()
                    
                    Image("signIn")
                        .resizable()
                        .frame(width: 250, height: 250)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 4))
                        .shadow(radius: 10.0, x: 20, y: 10)
                        .padding(.bottom, 50)
                    
                  
                    
                    VStack {
                        HStack {
                            Image(systemName: "person.crop.circle.fill")
                                .foregroundColor(Color(#colorLiteral(red: 0.6549019608, green: 0.7137254902, blue: 0.862745098, alpha: 1)))
                                .frame(width: 44, height: 44)
                                .background(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                                .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 5)
                                .padding(.leading)
                            
                            TextField("Your Email".uppercased(), text: $email)
                                .keyboardType(.emailAddress)
                                .font(.subheadline)
                                //                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.leading)
                                .frame(height: 44)
                                .onTapGesture {
                                    
                            }
                        }
                        
                        Divider().padding(.leading, 80)
                        
                        HStack {
                            Image(systemName: "lock.fill")
                                .foregroundColor(Color(#colorLiteral(red: 0.6549019608, green: 0.7137254902, blue: 0.862745098, alpha: 1)))
                                .frame(width: 44, height: 44)
                                .background(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                                .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 5)
                                .padding(.leading)
                            
                            SecureField("Password".uppercased(), text: $password)
                                .keyboardType(.default)
                                .font(.subheadline)
                                
                                .padding(.leading)
                                .frame(height: 44)
                            
                        }
                    }
                    .padding()
                    
                    Button(action: {
                        self.Authbserver.isLoading = true
                        self.Authbserver.signIn(email: self.email, password: self.password)
                            print(self.Authbserver.isLogIn)
                      
                            if self.Authbserver.isLogIn == true{
                                
                                helper.goHome()
                
                                self.showAlert = false
                               
                            }
                            else {
                                DispatchQueue.main.asyncAfter(deadline: .now()+1.2){
                                self.showAlert.toggle()
                                }}
                            
                        
                    }) {
                        
                        Text("Sign In")
                            .font(.headline)
                            .foregroundColor(.primary)
                            .padding()
                            .frame(width: 300, height: 50)
                            .background(Color.green.opacity(0.8))
                            .cornerRadius(20.0)
                            .shadow(radius: 5)
                    }
                    .alert(isPresented: $showAlert) { () -> Alert in
                        Alert(title: Text("Login Error"), message: Text("\(self.Authbserver.error)"), primaryButton: .default(Text("Okay"), action: {
                            print("Okay Click")
                        }), secondaryButton: .destructive(Text("Dismiss")))
                    }
                    .padding(.bottom)
                    
                    HStack(spacing:2){
                        Spacer()
                        Text("do not have an acount?")
                        Button(action: {
                            helper.goSignUp()
                        } ){
                            Text("Sign Up")
                                .font(.headline)
                                .foregroundColor(.green)
                                .padding()
                        }
                        
                        Spacer()
                    }
                    
                    Spacer()
                    
                }
                    
                .padding()
                .navigationBarTitle("Welcome back!")
            }
        }
        .offset(y: -keyboardResponder.currentHeight*0.9)
        
    }
  
}


struct signIn_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
        
        
        
        
    }
}
