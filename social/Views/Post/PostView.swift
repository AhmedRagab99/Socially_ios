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
     @State private var enlargeImage = false
    @State private var showPosts = false
    @State private var showComments = false
    @State private var showLikes = false
    @State private var text = ""
    @State private var pic = ""
    @State fileprivate var showAlert = false
    @State var showImagePicker: Bool = false
    @State var pickerImage: UIImage? = nil
    @State var showMyPosts: Bool
    
    @ObservedObject  var observer = PostsObserver()
    @ObservedObject  var Authobserver = AuthObserver()
    @EnvironmentObject var userState : AuthObserver
    @ObservedObject var keyboardResponder = KeyboardResponder()
    
    
    var body: some View {
        
        VStack{
                if observer.postObserver.count != 0 {
                    List(observer.postObserver,id: \.id) { item in
                        VStack(alignment:.leading){
                            
                            
                            
                            PostHeaderView(show: self.show, observer: self.observer,post:item)
                                .padding(.bottom,5)
                            
                            
                            
                            if item.pic != "no photo"{
                                    AnimatedImage(url: URL(string: item.pic ?? ""))
                                        .resizable()
                                       .cornerRadius(20)
                                      .scaledToFill()
                                        .shadow(color: Color.primary.opacity(0.7), radius: 3)
                                
                                
                            }
                            
                            LikeCommentView(commentViewState: self.showComments, userId: userId as! String, observer: self.observer, item: item)
                                .frame(maxHeight:40)
                            
                            
                            
                            LikesCommentDetailView(item: item, observer: self.observer, commentViewState: self.showComments)
                                .padding([.bottom])
                            
                            HStack(alignment: .bottom) {
                                Spacer()
                                Text("\(item.created?.substring(toIndex: 10) ?? "")")
                                  
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

        .onAppear {
            if showMyPosts{
            observer.getFollowingPosts()
            } else{
                observer.getMyPosts()
            }
        }
       
        }
    
    struct PostView_Previews: PreviewProvider {
        static var previews: some View {
            PostView(showMyPosts: false)
        }
    }
}
//struct addPostView:View{
//    
// 
//}
