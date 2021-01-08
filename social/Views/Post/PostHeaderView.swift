//
//  PostHeaderView.swift
//  social
//
//  Created by Ahmed Ragab on 7/14/20.
//  Copyright © 2020 Ahmed Ragab. All rights reserved.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI


struct PostHeaderView: View {
    @State  var show:Bool
    @ObservedObject  var observer : PostsObserver
    
    var post:Post
    var body: some View {
        VStack (alignment:.leading){
            HStack(){
                AnimatedImage(url: URL(string: post.user?.pic ?? ""))
                    .resizable()
                    .frame(maxWidth: 40, maxHeight: 40, alignment: .leading)
                    
                    .clipShape(Circle())
                
                
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
            

        }
        .padding(.top)
        }
    }




