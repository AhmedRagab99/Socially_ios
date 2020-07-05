//
//  TabBar.swift
//  social
//
//  Created by Ahmed Ragab on 7/4/20.
//  Copyright © 2020 Ahmed Ragab. All rights reserved.
//

import SwiftUI

struct TabBar: View {
    var body: some View {
        TabView {
            
            PostView()
                .tabItem {
                    Image(systemName: "square.and.pencil")
                       .imageScale(.large)
                    Text("posts")
            }
            
            
            
            PostView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                       .imageScale(.large)
                    Text("search")
            }
            
            PostView()
                .tabItem {
                    Image(systemName: "camera.fill")
                        .imageScale(.large)
                    Text("Camera")
                        .bold()
                        .font(.largeTitle)
            }
            
            PostView()
                .tabItem {
                    Image(systemName: "heart.fill")
                       .imageScale(.large)
                    Text("favorites")
            }
            
            
            PostView()
                .tabItem {
                    Image(systemName: "person.fill")
                       .imageScale(.large)
                    Text("profile")
            }
            
        }
        .accentColor(Color.green.opacity(0.7))
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
            .colorScheme(.dark)
    }
}