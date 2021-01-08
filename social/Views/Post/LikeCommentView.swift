//
//  LikeCommentView.swift
//  social
//
//  Created by Ahmed Ragab on 7/13/20.
//  Copyright © 2020 Ahmed Ragab. All rights reserved.
//

import Foundation
import SwiftUI

struct LikeCommentView: View {
    @State var likeState = false
    @State var commentState = false
    @State var likeimageName = "heart"
    @State var commentViewState:Bool
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
                    .foregroundColor(Color.primary)
                    .onTapGesture {
                        self.commentState.toggle()
                        self.commentViewState.toggle()
                }
                   .sheet(isPresented: $commentViewState, onDismiss: {
                                                 self.commentViewState = false
                                             }, content: {
                                                CommentsView(item: self.item, observer: self.observer)
                                             })
                
                
                
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
