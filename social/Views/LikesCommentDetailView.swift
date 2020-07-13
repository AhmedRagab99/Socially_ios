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
       @State var commentViewState:Bool
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
                    .padding(.trailing)
                    
                    
                    Button(action: {
                        
                    }) {
                        Text("liked by \(item.likes?.count ?? 0) users")
                    }
                    .foregroundColor(.secondary)
                    
                    Spacer()
                }
            }
            
            Spacer()
            
            
            
            if item.comments?.count != 0 {
              
                    Text("View all \(item.comments?.count ?? 0)  comments")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .onTapGesture {
                            self.commentViewState.toggle()
                    }
                .padding(.horizontal)
                .sheet(isPresented: $commentViewState, onDismiss: {
                    self.commentViewState = false
                }, content: {
                   CommentsView(item: self.item, observer: self.observer)
                })
                
                
            }
        }
        
    }
}
