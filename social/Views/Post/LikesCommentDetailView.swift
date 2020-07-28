//
//  LikesCommentDetailView.swift
//  social
//
//  Created by Ahmed Ragab on 7/13/20.
//  Copyright © 2020 Ahmed Ragab. All rights reserved.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI


struct LikesCommentDetailView: View {
    let item:Post
    let observer:PostsObserver
    //@Environment(\.presentationMode) var presentationMode

       @State var commentViewState:Bool
    //  @State var likeViewState:Bool
    var body: some View {
        VStack(alignment:.leading){
            
            
            HStack(spacing:2){
                
                Text("@\(item.user?.name ?? "") ")
                    .font(.headline)
                    .foregroundColor(.blue)
                VStack {
                    Text("\(item.text ?? "")")
                        .font(.headline)
                        .foregroundColor(.primary)
                }
            }
            HStack(alignment: .center, spacing: 0){
                
                if (item.likes?.count != 0){
                    ZStack(alignment: .leading){
                        
                        AnimatedImage(url: URL(string: item.user?.pic ?? ""))
                            .resizable()
                            .clipShape(Circle())
                            .frame(width: 30, height: 30, alignment: .topLeading)
                        
                        if item.likes?.count ?? 0 > 1{
                            ZStack(alignment: .leading){
                                AnimatedImage(url: URL(string: userPic as? String ?? ""))
                                    .resizable()
                                    .clipShape(Circle())
                                    .frame(width:30 , height: 30, alignment: .topTrailing)
                            }
                            .frame(width: 34, height: 34)
                            .padding(.horizontal,10)
                        }
                    }
                    .padding(.trailing)
                    
                    
             
                        Text("liked by \(item.likes?.count ?? 0) users")
                            .onTapGesture {
                              //  self.likeViewState.toggle()
                    }
                    .foregroundColor(.secondary)
                    .sheet(isPresented: $commentViewState, onDismiss: {
                                       self.commentViewState = false
                                       print(self.commentViewState)

                                   }, content: {
                                      CommentsView(item: self.item, observer: self.observer)
                               })
                 
                    
                }
            }
            
            Spacer()
            
            
            
            
            
            
            if item.comments?.count != 0 {
              
                    Spacer()
                    Text("View all \(item.comments?.count ?? 0)  comments")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .onTapGesture {
                                self.commentViewState.toggle()
                                print(self.commentViewState)
                        }
                    .sheet(isPresented: $commentViewState, onDismiss: {
                        self.commentViewState = false
                        print(self.commentViewState)

                    }, content: {
                       CommentsView(item: self.item, observer: self.observer)
                })
                
            }
        }
        
    }
}
