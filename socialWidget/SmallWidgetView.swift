//
//  SmallWidgetView.swift
//  social
//
//  Created by Ahmed Ragab on 8/5/20.
//  Copyright © 2020 Ahmed Ragab. All rights reserved.
//

import SwiftUI

struct SmallWidgetView: View {
    var body: some View {
        VStack (alignment:.leading,spacing:4){
            Text("Newest")
                .font(Font.footnote.smallCaps())
                .foregroundColor(.secondary)
            
            Image("test")
                .resizable()
                
                .cornerRadius(15)
            
            
            Text("Hellow From Paris With Socially App")
                .font(.subheadline)
                .fontWeight(.semibold)
                
        }
        
    }
}

struct SmallWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        SmallWidgetView()
    }
}
