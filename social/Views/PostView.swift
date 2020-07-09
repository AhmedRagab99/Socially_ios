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

let userPic = UserDefaults.standard.object(forKey: "userPic")
 let userId = UserDefaults.standard.object(forKey: "userId")
//let userName = UserDefaults.standard.object(forKey: "userName")
//let userFollowers = UserDefaults.standard.object(forKey: "userId")
 
 
struct PostView: View {
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
    
 
    
    var body: some View {
        
        NavigationView{
            ZStack {
              
                if self.observer.isLoading == true{
                    VStack{
                        LoadingView(isLoading:self.observer.isLoading,retryAction: nil)
                    }
                }
                
                if observer.postObserver.count != 0 {
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
                            
                            LikeCommentView(userId: userId as! String, observer: self.observer, item: item)
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
                    
              
                                       
                        
                    .alert(isPresented:$show) { () -> Alert in
                        Alert(title: Text("Login Error"), message: Text("\(self.observer.error)"), primaryButton: .default(Text("Okay"), action: {
                            print("Okay Click")
                        }), secondaryButton: .destructive(Text("Dismiss")))
                    }
                } else {
                    Text("Empty View")
                  
                    
                }
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
                                                           
                                                           AnimatedImage(url:URL(string: userPic as? String ?? ""))
                                                               .resizable()
                                                               .clipShape(Circle())
                                                               .frame(width: 40, height: 40)
                                                           
                                                           Button(action: {helper.goHome()}) {
                                                                                 Image(systemName:"arrow.2.squarepath")
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
  
                
                .onAppear(
                    perform: self.observer.getFollowingPosts
            )
        }
            
//
//        .sheet(isPresented: $showPosts, onDismiss: {
//            self.showPosts = false
//        }, content: {
//            addPostView(observer: self.observer, showImagePicker: self.showImagePicker, text: self.text, showAlert: self.showAlert, showPosts: self.showPosts, pic: self.pic, show: self.show)
//                .offset(y: -self.keyboardResponder.currentHeight*0.2)
//                .padding()
//                .frame(height: 800)
//
//        })
        
        
        
    
    }
    
    
    
}







struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView()
    }
}
//struct addPostView:View{
//    
// 
//}

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
    @State var likeState = false
    @State var commentState = false
    @State var likeimageName = "heart"
    var userId:String
    @State var commentimageName = "heart"
    var observer:PostsObserver
    var item:Post
    @State var Imagecolor = Color.primary
    
    
    var body: some View {
        
        HStack {
            HStack(spacing:16){
                
                Image(systemName:likeimageName)
                    .padding(.leading,3)
                    .foregroundColor(Imagecolor)
                    
                    .onTapGesture {
                        self.likeState.toggle()
                        
                        if self.likeState == true {
                            self.likeimageName = "heart.fill"
                            self.observer.likePost(postId: self.item.id! )
                            self.Imagecolor = Color.red
                            
                        }else{
                            self.likeimageName = "heart"
                            self.observer.unlikePost(postId: self.item.id!)
                            self.likeState.toggle()
                            self.Imagecolor = Color.primary

                        }
                }
                .onAppear{
                    if (self.item.likes?.contains(self.userId))!{
                        self.likeimageName = "heart.fill"
                        self.Imagecolor = Color.red
                        self.likeState = true
                    }
                }
                
                
                
                
                
                Image(systemName:"bubble.left")
                    .foregroundColor(commentState ? Color.red : Color.primary)
                    .onTapGesture {
                        self.commentState.toggle()
                        
                }
                
                
                
                Image(systemName:"paperplane")
                    
                    .foregroundColor(.primary)
                
                
                
                
                
                Spacer()
                
                Image(systemName:"bookmark")
                    
                    .padding(.trailing,8)
                    .scaledToFill()
                    .foregroundColor(.primary)
                
            }
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

