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

struct ProfileView: View {
    @State private var show = false
    @State private var showPosts = false
    @State private var text = ""
    @State private var pic = ""
    @State fileprivate var showAlert = false
    @State var showImagePicker: Bool = false
    @State var pickerImage: UIImage? = nil
    
    @ObservedObject  var observer = PostsObserver()
    @ObservedObject  var Authobserver = AuthObserver()
    @EnvironmentObject var userState : AuthObserver
    @ObservedObject var keyboardResponder = KeyboardResponder()
    
    let userPic = UserDefaults.standard.object(forKey: "userPic")
    let userId = UserDefaults.standard.object(forKey: "userId")
    
    
    
    var body: some View {
        
        
        
        ScrollView(.vertical,showsIndicators:false){
            
            
            VStack(alignment:.leading,spacing:5){
                HStack{
                    //Image("test")
                    AnimatedImage(url: URL(string: userPic  as! String))
                        .resizable()
                        .clipShape(Circle())
                        .frame(width: 100, height: 100, alignment: .leading)
                    Spacer()
                    
                    VStack{
                        Text("12")
                        Text("Posts")
                    }
                    Spacer()
                    VStack{
                        Text("12")
                        Text("Posts")
                    }
                    Spacer()
                    VStack{
                        Text("12")
                        Text("Posts")
                    }
                    Spacer()
                }
                .padding(.horizontal)
                
                Text("Ahmed Ragab")
                    .font(.largeTitle)
                    .padding()
                
                Spacer()
                ScrollView(.horizontal,showsIndicators: false){
                    HStack{
                        ForEach(observer.postObserver){ item in
                            
                            //Image("test")
                            AnimatedImage(url: URL(string: item.pic ?? ""))
                                .resizable()
                                .clipShape(Circle())
                                .frame(width: 80, height: 80)
                            
                            
                        }
                    }
                }
                .padding(.leading)
                Spacer()
             
                
                ZStack {
                    if self.observer.isLoading == true{
                        VStack{
                            LoadingView(isLoading:self.observer.isLoading,retryAction: nil)
                        }
                    }
                    
                    if observer.postObserver.count != 0 {
                        ForEach(observer.postObserver,id: \.id) { item in
                            VStack(alignment:.leading){
                                
                                
                                PostHeaderView(show: self.show, observer:    self.observer,post:item)
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
                                
                                LikeCommentView(userId: self.userId as! String, observer: self.observer, item: item)
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
                                
                                Button(action: {helper.goHome()}) {
                                    Image(systemName:"arrow.2.squarepath")
                                        .foregroundColor(Color.primary)
                                        .imageScale(.large)
                                }
                                
                                
                                Button(action: {self.showPosts.toggle()}) {
                                    Image(systemName:"plus.app")
                                        .foregroundColor(Color.primary)
                                        .imageScale(.large)
                                }
                                
                            }
                        )
                            .navigationBarTitle(
                                Text("Following")
                                    .font(.title)
                                    .foregroundColor(Color.primary.opacity(0.82))
                        )
                            
                            
                            .alert(isPresented:$show) { () -> Alert in
                                Alert(title: Text("Login Error"), message: Text("\(self.observer.error)"), primaryButton: .default(Text("Okay"), action: {
                                    print("Okay Click")
                                }), secondaryButton: .destructive(Text("Dismiss")))
                        }
                    } else {
                        Text("Empty View")
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
                                    
                                    Button(action: {helper.goHome()}) {
                                        Image(systemName:"arrow.2.squarepath")
                                            .foregroundColor(Color.primary)
                                            .imageScale(.large)
                                    }
                                    
                                    
                                    Button(action: {self.showPosts.toggle()}) {
                                        Image(systemName:"plus.app")
                                            .foregroundColor(Color.primary)
                                            .imageScale(.large)
                                    }
                                    
                                }
                        )
                            .navigationBarTitle(
                                Text("Following")
                                    .font(.title)
                                    .foregroundColor(Color.primary.opacity(0.82))
                        )
                        
                    }
                }
                .padding()
                
                
            }
            .padding(.top)
                
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            
            
        }
        .onAppear(
            perform: self.observer.getMyPosts
        )
        
        
        
        
        
        
    }
    
}







struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
