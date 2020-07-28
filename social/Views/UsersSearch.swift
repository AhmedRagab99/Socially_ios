//
//  UsersSearch.swift
//  social
//
//  Created by Ahmed Ragab on 7/27/20.
//  Copyright © 2020 Ahmed Ragab. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct UsersSearch: View {
    @ObservedObject var UserViewModel = UserObserver()
    @State var showUser = false
   
    private var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    @State var searchTerm = ""
    var body: some View {
        
    
            VStack(spacing:20) {

                SearchBar(text: $searchTerm)
                    .padding(.top)
            
                ScrollView {
                      LazyVGrid(columns: gridItemLayout, spacing: 20) {
                        
                        ForEach(UserViewModel.allUser) { item in
                            
                            VStack {
                                AnimatedImage(url: URL(string: item.pic ?? ""))
                                    .resizable()
                                    .clipShape(Circle())
                                    .frame(width: 80, height: 80, alignment: .center)

                                Text(item.email ?? "UserName")
                                    .font(.subheadline)
                                    .fontWeight(.light)
                                    .foregroundColor(.secondary)
                            }
                            .onTapGesture {
                                showUser.toggle()
                            }
                        }
                      }
                  }
           
            }
            
            

            .onAppear {
                UserViewModel.getAllUsers()
            }
            
            .sheet(isPresented: $showUser, onDismiss: {
                showUser = false
                                      }, content: {
                                      ProfileView()
                                  })
        }
        
    


struct UsersSearch_Previews: PreviewProvider {
    static var previews: some View {
        UsersSearch()
    }
}
}
