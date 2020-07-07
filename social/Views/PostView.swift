//
//  PostView.swift
//  social
//
//  Created by Ahmed Ragab on 6/29/20.
//  Copyright © 2020 Ahmed Ragab. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI
import Alamofire

struct PostView: View {
    @State private var show = false
    @State private var showPosts = false
    @State private var text = ""
    @State private var pic = ""
    @State private var showAlert = false
    @State var showImagePicker: Bool = false
    @State var pickerImage: UIImage? = nil
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject  var observer = PostsObserver()
    @ObservedObject  var Authobserver = AuthObserver()
    @EnvironmentObject var userState : AuthObserver
    @ObservedObject var keyboardResponder = KeyboardResponder()
    
    let userPic = UserDefaults.standard.object(forKey: "userPic")
    
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    var body: some View {
        
        NavigationView{
            ZStack {
                if self.observer.isLoading == true{
                                 VStack{
                                     LoadingView(isLoading:self.observer.isLoading,retryAction: nil)
                                 }
                             }
                             
                List(observer.postObserver,id: \.id) { item in
                    VStack(alignment:.leading){
                        
                        
                        PostHeaderView(show: self.show, observer: self.observer,post:item)
                            .padding(.bottom,5)
                        
                        
                        VStack{
                            Text("\(item.text ?? "")")
                                .font(.headline)
                                .foregroundColor(.primary)
                            
                        }
                        .padding(.leading,4)
                        
                        if item.pic != "no photo"{
                            AnimatedImage(url: URL(string: item.pic ?? ""))
                                .resizable()
                                .aspectRatio(contentMode: self.show ? .fit: .fill)
                            
                        }
                        
                        LikeCommentView()
                            .frame(maxHeight:40)
                            .padding(.bottom,8)
                        
                        
                        
                        LikesCommentDetailView(item: item)
                            .padding([.bottom])
                        
                        HStack(alignment: .bottom) {
                            Spacer()
                            Text("\(item.created?.substring(toIndex: 10) ?? "")")
//                            Text("\(helper.convertDateFormatter(date: item.created. ?? " "))")
                                .font(.headline)
                                .foregroundColor(.secondary)
                        }
                        .padding(.bottom)
                    }
                    .padding(.vertical)
                }
                .onAppear(
                    perform: self.observer.getMyPosts
                )
                    .alert(isPresented:$show) { () -> Alert in
                        Alert(title: Text("Login Error"), message: Text("\(self.observer.error)"), primaryButton: .default(Text("Okay"), action: {
                            print("Okay Click")
                        }), secondaryButton: .destructive(Text("Dismiss")))
                }
                .navigationBarItems(leading:

                        Button(action: {
                            helper.deleteApiToken()
                            helper.goSignIn()
                        }) {
                            Text("logout")
                                .font(.headline)
                                .foregroundColor(.green)
                        }
                    ,trailing:
                    HStack(spacing:15) {
                        
                        AnimatedImage(url:URL(string: self.userPic as? String ?? ""))
                            .resizable()
                            .clipShape(Circle())
                            .frame(width: 40, height: 40)
                        
                        
                        Button(action: {self.showPosts.toggle()}) {
                            Image(systemName:"plus.app")
                                .foregroundColor(Color.primary)
                                .imageScale(.large)
                        }
                        
                    }
                )
            }
        }
        .sheet(isPresented: $showPosts, onDismiss: {
            self.showPosts = false
        }, content: {
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
                            .overlay(Rectangle().stroke(Color.white, lineWidth: 4))
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
                            .frame(width: 300, height: 50)
                            .background(Color.green.opacity(0.8))
                            .cornerRadius(20.0)
                            .shadow(radius: 5)
                        
                    }
                    .alert(isPresented: self.$showAlert) { () -> Alert in
                                         Alert(title: Text("Post Created Successfully"), message: Text("\(self.observer.error)"), primaryButton: .default(Text("Okay"), action: {
                                             print("Okay Click")
                                            self.showAlert.toggle()
                                            self.showPosts.toggle()
                                            self.presentationMode.wrappedValue.dismiss()

                                         }), secondaryButton: .destructive(Text("Dismiss")))
                                     }
                                     .padding(.bottom)
       
                    
                    Spacer()
                    
                }
            }
            .offset(y: -self.keyboardResponder.currentHeight*0.2)
            .padding()
            .frame(height: 800)
            .onTapGesture {
                self.hideKeyboard()
                self.show.toggle()
            }
            
            
            
            
        })
      
          
          
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
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                self.showAlert.toggle()
                                self.show = false
                                helper.goHome()
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













struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView()
    }
}

struct PostHeaderView: View {
    @State  var show:Bool
    @ObservedObject  var observer : PostsObserver

    var post:Post
    var body: some View {
        HStack(alignment: .center,spacing:4){
            AnimatedImage(url: URL(string: post.user?.pic ?? ""))
                .resizable()
                .clipShape(Circle())
                .frame(width: 50, height: 40, alignment: .leading)
            
            
            Text("\(post.user?.name ?? "")")
                .font(.headline)
                .foregroundColor(.primary)
            
            Spacer()
        
                Text("...")
                    .font(.headline)
                    .onTapGesture {
                        self.show.toggle()
                }
            .foregroundColor(.primary)
            .actionSheet(isPresented: $show) { () -> ActionSheet in
              ActionSheet(title: Text("Menu"), message: Text("Select your options"),
             buttons: [
                .destructive(Text("Ok"), action: {
                    self.observer.deletePost(postId: self.post.id ?? "")
                    helper.goHome()
                }),
                .default(Text("Cancel"), action: {
                    print("Cancel selected")
                })
              ])
            }
            
        }
        .padding(.trailing,12)
        .padding(.leading,-4)
        .frame(maxWidth:.infinity,maxHeight: 44)
    }
}

struct LikeCommentView: View {
    var body: some View {
        HStack(spacing:16){
            Button(action: {}) {
                Image(systemName:"heart")
            }
            .padding(.leading,3)
            .scaledToFill()
            .foregroundColor(.primary)
            
            
            
            Button(action: {}) {
                Image(systemName:"bubble.left")
            }
            .scaledToFill()
            .foregroundColor(.primary)
            
            
            Button(action: {}) {
                Image(systemName:"paperplane")
            }
            .scaledToFill()
            .foregroundColor(.primary)
            
            
            
            
            
            Spacer()
            Button(action: {}) {
                Image(systemName:"bookmark")
            }
            .padding(.trailing,8)
            .scaledToFill()
            .foregroundColor(.primary)
            
        }
    }
}

struct LikesCommentDetailView: View {
    let item:Post
    
    var body: some View {
        VStack(alignment:.leading){
            HStack(alignment: .center, spacing: 0){
                
                if (item.likes?.count != 0){
                    ZStack(alignment: .leading){
                        
                        AnimatedImage(url: URL(string: item.user?.pic ?? ""))
                            .resizable()
                            .clipShape(Circle())
                            .frame(width: 30, height: 30, alignment: .topLeading)
                        
                        if item.likes?.count ?? 0 > 1{
                            ZStack(alignment: .leading){
                                Image("test")
                                    .resizable()
                                    .clipShape(Circle())
                                    .frame(width:30 , height: 30, alignment: .topTrailing)
                            }
                            .frame(width: 34, height: 34)
                            .padding(.horizontal,10)
                        }
                    }
                    
                    
                    Button(action: {}) {
                        Text("liked by \(item.likes?.count ?? 0) users")
                    }
                    .foregroundColor(.secondary)
                    
                    Spacer()
                }
            }
            
            
            
            
            
            if item.comments?.count != 0 {
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    Text("View all \(item.comments?.count ?? 0)  comments")
                }
                .padding(.horizontal)
                .foregroundColor(.secondary)
                
            }
        }
    }
}

extension String {

    var length: Int {
        return count
    }

    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }

    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }

    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }

    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
}
