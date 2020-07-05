//
//  PostView.swift
//  social
//
//  Created by Ahmed Ragab on 6/29/20.
//  Copyright © 2020 Ahmed Ragab. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct PostView: View {
    @State private var show = false
    @ObservedObject  var observer = PostsObserver()
    var body: some View {
        
        
        
     
                List(observer.postObserver,id: \.id) { item in
                    VStack(alignment:.leading){
                        
                        
                        PostHeaderView(show: self.show,post:item)
                            .padding(.bottom,5)
                        
                        
                        VStack {
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
                        .frame(maxHeight:40)
                        .padding(.bottom,8)
                        
                        
                        
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
                        .padding([.bottom])
                        
                        HStack(alignment: .bottom) {
                            Spacer()
                            Text("\(item.created?.replacingOccurrences(of: "GMT+0200 (Eastern European Standard Time)", with: "") ?? "")")
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
           
        }
        
    }
    
    









struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView()
    }
}

struct PostHeaderView: View {
    @State  var show:Bool
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
            Button(action: {
                self.show.toggle()
            }) {
                Text("...")
                    .font(.headline)
            }
            .foregroundColor(.primary)
            
        }
        .padding(.trailing,12)
        .padding(.leading,-4)
        .frame(maxWidth:.infinity,maxHeight: 44)
    }
}
