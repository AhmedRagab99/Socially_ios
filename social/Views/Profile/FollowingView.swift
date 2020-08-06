//
//  FollowingView.swift
//  social
//
//  Created by Ahmed Ragab on 8/6/20.
//  Copyright © 2020 Ahmed Ragab. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct FollowingView: View {
    @ObservedObject var userViewModel:UserObserver
    var body: some View {

        VStack(alignment:.leading) {
            ScrollView(.vertical, showsIndicators: false) {

                    
                    ForEach(userViewModel.allUser) { item in
                        
                        if let f = userViewModel.singleUserData.user?.following {
                            //Print(f,ProfileUserId,userId as! String )
                            
                            if f.contains("\(item.id ?? "")") {
                               // debugPrint(f)
                               
                                    VStack(spacing:8) {
                                        
                                   
                                        
                                        //Image("test")
                                        AnimatedImage(url: URL(string: item.pic ?? ""))
                                            .resizable()
                                            .clipShape(Rectangle())
                                            .frame(width: 220, height:220)
                                            .cornerRadius(20)
                                            .shadow(color:Color.primary,radius:3)
                                            .padding()
                                            
                                            
                                        
                                        Text("\(item.name ?? "")")
                                            .font(.headline)
                                            .foregroundColor(Color.primary.opacity(0.8))
                                    }
                                
                                Spacer()
                            }
                        }
                        
                    
                 
                    Spacer()
                }
            }
            Spacer()
        }

    }
}

//struct FollowingView_Previews: PreviewProvider {
//    static var previews: some View {
//        FollowingView()
//    }
//}
