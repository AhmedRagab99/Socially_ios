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
    @State  var commentViewState = false
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
                            if item.pic != "no photo"{
                                AnimatedImage(url: URL(string: item.pic ?? ""))
                                    .resizable()
                                    .clipShape(Circle())
                                    .frame(width: 80, height: 80)
                            }
                            
                            
                        }
                    }
                }
                .padding(.leading)
                
                Spacer()
            }
            
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
