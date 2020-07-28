//
//  PostView.swift
//  social
//
//  Created by Ahmed Ragab on 6/29/20.
//  Copyright © 2020 Ahmed Ragab. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI
import Alamofire

struct ProfileView: View {
    @State private var favoriteColor = 0
    var colors = ["Red", "Green", "Blue"]
    
    @State var listView = false
    @State var gridView = false
    @State var complexGrid = false
    
    
    var body: some View {
        ScrollView{
            VStack{
                ProfileHeaderView()
                    .padding()
                HStack(spacing:20){
                    
                    
                    VStack {
                        
                        Image(systemName: "heart.fill")
                            .imageScale(.large)
                            .foregroundColor(.gray)
                        
                        
                    }
                    .frame(width: 100, height: 40, alignment: .center)
                    .background(gridView ? Color.blue: Color.white  )                .cornerRadius(10)
                    .onTapGesture {
                        gridView.toggle()
                        listView = false
                        complexGrid = false
                    }
                    
                    
                    VStack {
                        Image(systemName: "heart.fill")
                            .imageScale(.large)
                            .foregroundColor(.gray)
                        
                    }
                    .frame(width: 100, height: 40, alignment: .center)
                    .background(listView ? Color.blue: Color.white  )                .cornerRadius(10)
                    .onTapGesture {
                        gridView = false
                        listView .toggle()
                        complexGrid = false
                    }
                    
                    
                    VStack {
                        Image(systemName: "heart.fill")
                            .imageScale(.large)
                            .foregroundColor(.gray)
                        
                        
                    }
                    .frame(width: 100, height: 40, alignment: .center)
                    .background(complexGrid ? Color.blue: Color.white  )
                    .cornerRadius(10)
                    .onTapGesture {
                        gridView  = false
                        listView = false
                        complexGrid .toggle()
                    }
                    
                    
                    
                }
                .padding(.horizontal)
                .padding(.vertical)
                .background(Color.secondary.opacity(0.08))
                .cornerRadius(15)
                
                
                ForEach(0 ..< 5) { item in
                    Image("test")
                        .resizable()
                        .clipShape(Rectangle())
                        .cornerRadius(20)
                        .padding()
                }
            }
            
            
            
            Spacer()
        }
        .clipShape(Rectangle())
        .cornerRadius(20)
    }
}




struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
        
    }
}
