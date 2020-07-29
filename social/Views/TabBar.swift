//
//  TabBar.swift
//  social
//
//  Created by Ahmed Ragab on 7/4/20.
//  Copyright © 2020 Ahmed Ragab. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct TabBar: View {
    
    var body: some View {
        
        
        TabView {
            
            NavigationView{
                PostView()
                    .navigationBarTitle("Following")
                    
                    .navigationBarItems(leading:
                                            
                                            Button(action: {
                                                helper.deleteApiToken()
                                                helper.goSignIn()
                                            }) {
                                                Text("logout")
                                                    .font(.headline)
                                                    .foregroundColor(.green)
                                            }
                                        ,trailing:
                                            HStack(spacing:15) {
                                                
                                                AnimatedImage(url:URL(string: userPic as? String ?? ""))
                                                    .resizable()
                                                    .clipShape(Circle())
                                                    .frame(width: 40, height: 40)
                                                
                                                Button(action: {
                                                    
                                                    helper.goHome()
                                                    
                                                    
                                                }) {
                                                    Image(systemName:"arrow.2.squarepath")
                                                        .foregroundColor(Color.primary)
                                                        .imageScale(.large)
                                                }
                                                
                                                
                                                
                                                
                                            }
                    )
            }
            .tabItem {
                Image(systemName: "square.and.pencil")
                    .imageScale(.large)
                Text("posts")
            }
            
            
         
            NavigationView {
                UsersSearch()
                    .navigationTitle("Search")
            }
            
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                            .imageScale(.large)
                        Text("search")
                }
            
            
            
            
            NavigationView{
                addPostView()
                    
                    
                    .navigationBarItems(leading:
                                            
                                            Button(action: {
                                                helper.deleteApiToken()
                                                helper.goSignIn()
                                            }) {
                                                Text("logout")
                                                    .font(.headline)
                                                    .foregroundColor(.green)
                                            }
                                        ,trailing:
                                            HStack(spacing:15) {
                                                
                                                AnimatedImage(url:URL(string: userPic as? String ?? ""))
                                                    .resizable()
                                                    .clipShape(Circle())
                                                    .frame(width: 40, height: 40)
                                                
                                                Button(action: {
                                                    
                                                    helper.goHome()
                                                    
                                                    
                                                }) {
                                                    Image(systemName:"arrow.2.squarepath")
                                                        .foregroundColor(Color.primary)
                                                        .imageScale(.large)
                                                }
                                                
                                                
                                                
                                                
                                            }
                    )
            }
            .tabItem {
                Image(systemName: "plus.app.fill")
                    .imageScale(.large)
                Text("Camera")
                    .bold()
                    .font(.largeTitle)
            }
            
            NavigationView{
                
                PostView()
                  
                    .navigationBarTitle("Following")

                    
                    .navigationBarItems(leading:
                                            
                                            Button(action: {
                                                helper.deleteApiToken()
                                                helper.goSignIn()
                                            }) {
                                                Text("logout")
                                                    .font(.headline)
                                                    .foregroundColor(.green)
                                            }
                                        ,trailing:
                                            HStack(spacing:15) {
                                                
                                                AnimatedImage(url:URL(string: userPic as? String ?? ""))
                                                    .resizable()
                                                    .clipShape(Circle())
                                                    .frame(width: 40, height: 40)
                                                
                                                Button(action: {
                                                    
                                                    helper.goHome()
                                                    
                                                    
                                                }) {
                                                    Image(systemName:"arrow.2.squarepath")
                                                        .foregroundColor(Color.primary)
                                                        .imageScale(.large)
                                                }
                                                
                                                
                                                
                                                
                                            }
                    )
            }
            .tabItem {
                Image(systemName: "heart.fill")
                    .imageScale(.large)
                Text("favorites")
            }
            

    
            NavigationView {
                ProfileView()
                    .navigationTitle("Profile")
          
            }
            .tabItem {
                Image(systemName: "person.fill")
                    .imageScale(.large)
                Text("profile")
        }
            
            
            
        }
        
    }
    
}



struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
            .colorScheme(.dark)
    }
}
