//
//  addPostView.swift
//  social
//
//  Created by Ahmed Ragab on 7/9/20.
//  Copyright © 2020 Ahmed Ragab. All rights reserved.
//

import SwiftUI
import Alamofire

struct addPostView: View {
    @State private var show = false
    @State private var showPosts = false
    @State private var text = ""
    @State private var pic = ""
    @State fileprivate var showAlert = false
    @State var showImagePicker: Bool = false
    @State var pickerImage: UIImage? = nil
    @ObservedObject var keyboardResponder = KeyboardResponder()
    
    var observer = PostsObserver()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        VStack {
            ZStack{
                       if self.observer.isLoading == true{
                           VStack{
                               LoadingView(isLoading:self.observer.isLoading,retryAction: nil)
                           }
                       }
                       VStack(spacing:10){
                           VStack {
                               Image(uiImage: (self.pickerImage ?? UIImage(named:"test"))!)
                                   .resizable()
                                   .frame(width: 350, height: 350)
                                   .clipShape(Rectangle())
                                .overlay(Rectangle().stroke(Color.primary.opacity(0.4), lineWidth: 4))
                                   .shadow(radius: 10.0, x: 20, y: 10)
                                   .padding(.bottom, 50)
                                   .cornerRadius(10)
                                   .onTapGesture {
                                       withAnimation{
                                           self.showImagePicker.toggle()
                                       }
                               }
                                   //5
                                   .sheet(isPresented: self.$showImagePicker, onDismiss: {
                                       self.showImagePicker = false
                                   }, content: {
                                       ImagePicker(image: self.$pickerImage, isShown: self.$showImagePicker)
                                   })
                               
                           }
                           
                           
                           TextField("What's in your mind :".uppercased(), text: self.$text)
                               .keyboardType(.default)
                               .font(.subheadline)
                               .padding(.leading)
                               .frame(height: 44)
                           
                        Spacer()
                           Button(action: {
                               self.observer.isLoading = true
                               
                               if self.pic != " " && self.text != " "{
                                   self.uploadPhoto(url: Constants.imgurBaseUrl, image: self.pickerImage!, header: ["Authorization":Constants.clientId])
                                   
                               }
                           }) {
                               Text("Post")
                                   .font(.headline)
                                   .foregroundColor(.primary)
                                   .padding()
                                   .frame(width: 150, height: 50)
                                   .background(Color.blue.opacity(0.8))
                                   .cornerRadius(20.0)
                                   .shadow(radius: 5)
                               
                           }
                           .alert(isPresented: self.$showAlert) { () -> Alert in
                               Alert(title: Text("Post Created Successfully"), message: Text("\(self.observer.error)"), primaryButton: .default(Text("Okay"), action: {
                                   print("Okay Click")
                                   self.showAlert.toggle()
                                   self.showPosts.toggle()
                                  helper.goHome()
                                   self.presentationMode.wrappedValue.dismiss()
                                
                                   
                               }), secondaryButton: .destructive(Text("Dismiss")))
                           }
                           .padding(.bottom)
                           
                           
                           Spacer()
                           
                       }
            }
            .offset(y: -keyboardResponder.currentHeight*0.6)
        }
       
        .padding()
              
               
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
                                      
                                      self.observer.createPost(text: self.text, imageUrl: self.pic)
                                      DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                          self.showAlert.toggle()
                                          self.show = false
                                          //helper.goHome()
                                          
                                      }
                                      
                                  }
                              } catch {
                                  // Display an error
                                  print(error)
                              }
                          case .failure(let err):
                              print("upload err: \(err)")
                          }
                  }
              }
}

struct addPostView_Previews: PreviewProvider {
    static var previews: some View {
        addPostView()
    }
}
