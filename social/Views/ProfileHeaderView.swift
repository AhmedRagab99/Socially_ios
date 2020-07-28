//
//  ProfileHeaderView.swift
//  social
//
//  Created by Ahmed Ragab on 7/27/20.
//  Copyright © 2020 Ahmed Ragab. All rights reserved.
//

import SwiftUI

struct ProfileHeaderView: View {
    var body: some View {
        VStack {
            VStack(alignment:.center){
                Image("test")
                    .resizable()
                    .clipShape(Circle())
                    .frame(width: 150, height: 150, alignment: .center)
                    .shadow(color: Color.primary.opacity(0.7),radius: 5)
                    .padding()
                
                Text("Ahmed Ragab")
                    .font(.headline)
                    .foregroundColor(.primary)
                    
                    .padding()
                   
                
                Text("I am a backend devloper write code with js and node js and php thst is a backend with a react js and angular as a front end framework")
                    .multilineTextAlignment(.center)
                    .lineLimit(3)
                    .padding()
                
                
                
                HStack(spacing:8) {
                   
                    Button(action: {}) {
                        Text("Follow")
                            .padding()
                            .font(.caption)
                            .foregroundColor(.white)
                    }
                    .background(Color.blue.opacity(0.7))
                    .cornerRadius(10)
                    
                    Button(action: {}) {
                        Text("UnFollow")
                            .padding()
                            .font(.caption)
                            .foregroundColor(.white)
                    }
                    .background(Color.primary.opacity(0.5))
                    .cornerRadius(10)
                    
                    
                }
                
                
                HStack(spacing:20){
                    VStack(spacing:10){
                        Text("Followers")
                        Text("Followers")
                    }
                    .padding(.vertical)
                    VStack(spacing:10){
                        Text("Followers")
                        Text("Followers")
                    }
                    VStack(spacing:10){
                        Text("Followers")
                        Text("Followers")
                    }
                }
                .padding()
   
                
                
                Spacer()

            }
        }
        
        
    }
}

struct ProfileHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHeaderView()
    }
}
