//
//  LikesView.swift
//  social
//
//  Created by Ahmed Ragab on 7/27/20.
//  Copyright © 2020 Ahmed Ragab. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI
struct LikesView: View {

     @State var like = ""
        @State var showAlert = false
    //     @Environment(\.presentationMode) var presentationMode
        let post:Post
        @ObservedObject var keyboardResponder = KeyboardResponder()
        @ObservedObject var observer:PostsObserver
    var body: some View {
        
        ForEach(post.likes!,id:\.self)  { item in
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                   // Image("test")
                    AnimatedImage(url:URL(string:self.post.user?.pic ?? ""))
                        .resizable()
                        .clipShape(Circle())
                        .frame(width: 60, height: 60)
                    
                    Text("Hello, World!")
                        Spacer()
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                        Text("Follow")
                            .font(.callout)
                            .bold()
                            .padding()
                            .background(Color.blue)

                        }
                    .cornerRadius(20)
                    }
            }
        }
        
    
    }
}
//
//struct LikesView_Previews: PreviewProvider {
//    static var previews: some View {
//        LikesView()
//    }
//}
