//
//  SignUp.swift
//  social
//
//  Created by Ahmed Ragab on 7/5/20.
//  Copyright © 2020 Ahmed Ragab. All rights reserved.
//

import SwiftUI
import Alamofire
import UIKit

struct SignUpView: View {
    
    @ObservedObject var Authbserver = AuthObserver()
    @ObservedObject var keyboardResponder = KeyboardResponder()
    
    @State private var email = ""
    @State private var password = ""
    @State private var name = ""
    var link = ""
    @State private var pic = ""
    @State private var showAlert = false
    @State var showImagePicker: Bool = false
    @State var pickerImage: UIImage? = nil
    
    
    var body: some View {
        NavigationView {
            
            ScrollView{
                ZStack {
                    if self.Authbserver.isLoading == true{
                        VStack{
                            LoadingView(isLoading:self.Authbserver.isLoading,retryAction: nil)
                        }
                        
                    }
                    VStack(alignment: .center) {
                        
                        //3
                        VStack {
                            Image(uiImage: (pickerImage ?? UIImage(named:"test"))!)
                                .resizable()
                                .frame(width: 250, height: 250)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                                .shadow(radius: 10.0, x: 20, y: 10)
                                .padding(.bottom, 50)
                                .onTapGesture {
                                    withAnimation{
                                        self.showImagePicker.toggle()
                                    }
                            }
                                //5
                                .sheet(isPresented: $showImagePicker, onDismiss: {
                                    self.showImagePicker = false
                                }, content: {
                                    ImagePicker(image: self.$pickerImage, isShown: self.$showImagePicker)
                                })
                            
                        }
                        
                        Spacer()
                        
                        
                        
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
                                Image(systemName: "pencil")
                                    .foregroundColor(Color(#colorLiteral(red: 0.6549019608, green: 0.7137254902, blue: 0.862745098, alpha: 1)))
                                    .frame(width: 44, height: 44)
                                    .background(Color.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                                    .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 5)
                                    .padding(.leading)
                                
                                TextField("Your Name".uppercased(), text: $name)
                                    .keyboardType(.default)
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
                            
                            self.uploadPhoto(url: Constants.imgurBaseUrl, image: self.pickerImage!, header: ["Authorization":Constants.clientId])
                            
                            print(self.pic)
                            
                        }) {
                            Text("Sign Up")
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
                            Text("have an acount?")
                            Button(action: {
                                helper.goSignIn()
                            } ){
                                Text("Sign In now")
                                    .font(.headline)
                                    .foregroundColor(.green)
                                    .padding()
                            }
                            
                            Spacer()
                        }
                        
                        Spacer()
                    }
                    .offset(y: -keyboardResponder.currentHeight*0.9)
                   
                }
                
                
            }
       
            .padding(.vertical)
        }
        
    }
    
    
    
    
    
    func uploadPhoto(
        url: String,
        image: UIImage,
        header: [String:String]) {
        
        
        let httpHeaders = HTTPHeaders(header)
        AF.upload(multipartFormData: { multiPart in
            
            multiPart.append(image.jpegData(compressionQuality: 0.6)!, withName: "image", fileName: "file.jpg", mimeType: "image/jpg")
        }, to: url, method: .post, headers: httpHeaders)
            .responseJSON{ response  in
                switch response.result {
                case .success(let resut):
                    print("upload success result: \(String(describing: resut))")
                    var parsedResult: [String: AnyObject]
                    do {
                        parsedResult = try JSONSerialization.jsonObject(with: response.data!, options: .allowFragments) as! [String: AnyObject]
                        if let dataJson = parsedResult["data"] as? [String: Any] {
                            print("Link is : \(dataJson["link"] as? String ?? "Link not found")")
                            self.pic = dataJson["link"] as! String
                            print(self.pic)
                            
                            self.Authbserver.signUp(email: self.email, name: self.name, password: self.password, pic: self.pic)
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                print(self.Authbserver.isSignUn)
                                
                                if self.Authbserver.isSignUn == true{
                                    
                                    helper.goSignIn()
                                    self.showAlert = false
                                }
                                else {
                                    self.showAlert.toggle()
                                }
                                
                            }
                            
                        }
                    } catch {
                        // Display an error
                    }
                case .failure(let err):
                    print("upload err: \(err)")
                }
        }
    }
    
}

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
