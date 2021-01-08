//
//  CommentView.swift
//  social
//
//  Created by Ahmed Ragab on 7/13/20.
//  Copyright © 2020 Ahmed Ragab. All rights reserved.
//

import Foundation

import SwiftUI
import Combine
import SDWebImageSwiftUI

struct CommentsView:View {
    @State var comment = ""
    @State var showAlert = false
     @Environment(\.presentationMode) var presentationMode
    let item:Post
    @ObservedObject var keyboardResponder = KeyboardResponder()
    @ObservedObject var observer:PostsObserver
    var body : some View{
   
     
          
        
                
                VStack(alignment:.leading,spacing: 8){
                
                       
                    ScrollView{
                        ForEach(item.comments!,id:\.id) { i in
                            
                        VStack(alignment:.leading,spacing:2) {
                            HStack (spacing: 10){
                                //Image("test")
                                AnimatedImage(url:URL(string: i.userId?.pic ?? ""))
                                    .resizable()
                                    .clipShape(Circle())
                                    .frame(width: 60, height: 60)
                                VStack(alignment:.leading,spacing:5) {
                                    Text("\(i.userId?.name ?? "user Name")")
                                        .font(.headline)
                                        .foregroundColor(.secondary)
                                    Text("\(i.created ?? "")")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                                Spacer()
                                Button(action: {
                                    self.showAlert.toggle()
                                  
                                }){
                                    Text("...")
                                }
                                .alert(isPresented:self.$showAlert) { () -> Alert in
                                    Alert(title: Text("delete comment"), message: Text("\(self.observer.error)"), primaryButton: .default(Text("Ok"), action: {
                                        self.observer.uncomment(text: i.text ?? "", postId: self.item.id ?? "")
                                        // self.presentationMode.wrappedValue.dismiss()
                                            // helper.goHome()
                                        self.presentationMode.wrappedValue.dismiss()

                                    }), secondaryButton: .destructive(Text("Cancel")))
                                }
                                .foregroundColor(.primary)
                                
                            }
                            .padding([.top,.leading,.trailing])
                            
                            
                            Text("\(i.text ?? "")")
                                .font(.body)
                                .foregroundColor(Color.primary)
                                .padding()
                        }
                            .background(Color.gray.opacity(0.3))
                            .cornerRadius(20)
                    
                            
                            .frame(maxWidth:UIScreen.main.bounds.width - 30,maxHeight: UIScreen.main.bounds.height / 3)
                            .padding(.horizontal,6)
                        .padding(.top)
                        
                    }
                    }
                        
                       
                        Spacer()
                        HStack {
                           // Image("test")
                            AnimatedImage(url: URL(string: userPic as! String))
                                .resizable()
                                .clipShape(Circle())
                                .cornerRadius(10)
                                .frame(width: 40, height: 40)
                            HStack {
                                VStack (){
                                    
                                    TextField("Your Comment".uppercased(), text: self.$comment)
                                  
                                    
                                    
                                }
                                Spacer()
                                Text("Send")
                                    .foregroundColor(Color.blue)
                                    .onTapGesture {
                                       // print(self.item.id)
                                        self.observer.comment(text: self.comment, postId: self.item.id ?? "")
                                        self.presentationMode.wrappedValue.dismiss()
                                       // helper.goHome()
                                }
                            }
                            .padding(.horizontal,6)
                        }
                               .offset(y: -keyboardResponder.currentHeight*0.9)
                        .padding()
                }
           
            }
        }

    


//
//struct CommentsView_Previews: PreviewProvider {
//    static var previews: some View {
//        CommentsView(, observer: <#PostsObserver#>)
//    }
//}

