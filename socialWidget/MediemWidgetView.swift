//
//  MediemWidgetView.swift
//  social
//
//  Created by Ahmed Ragab on 8/5/20.
//  Copyright © 2020 Ahmed Ragab. All rights reserved.
//

import SwiftUI

struct MediemWidgetView: View {
    @State var name = " "
    var body: some View {
      
        VStack (alignment:.leading,spacing:2){
            Image("user1")
                .resizable()
               
                .cornerRadius(15)
                .padding()
            
            VStack(alignment:.center) {
                Text("I am Student at FCIS ASU Write ios Native and  BackEnd with Express FrameWork  ")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.secondary)
                    .padding([.leading,.trailing])
                    .frame(maxWidth:.infinity,maxHeight: 50)
            }
                
        }
    }
}

struct MediemWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        MediemWidgetView()
    }
}
