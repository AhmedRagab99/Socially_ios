//
//  SignUp.swift
//  social
//
//  Created by Ahmed Ragab on 6/28/20.
//  Copyright © 2020 Ahmed Ragab. All rights reserved.
//

import SwiftUI
import AVKit
struct SignUp: View {
    
    @State private var name:String = ""
    @State private var email:String = ""
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 10) {
            Image("test")
                .resizable(capInsets: .init(top: 4, leading: 4, bottom: 4, trailing: 4), resizingMode: .tile)
                .cornerRadius(150)
                .frame(minWidth: 150, maxWidth: 250, minHeight: 150, maxHeight: 250, alignment: .center)
                .padding(32)
            VStack{
                Text("welcome to our site")
                Text("welcome to our site")
                Text("welcome to our site")
            }
            .padding()
        }
        .padding()
    
    }
    
    
}

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp()
    }
}
