//
//  LottieView.swift
//  social
//
//  Created by Ahmed Ragab on 8/5/20.
//  Copyright © 2020 Ahmed Ragab. All rights reserved.
//

import SwiftUI
import Lottie

struct LottieView:UIViewRepresentable {
    
    typealias UIViewType = UIView
    var fileName:String
    
    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
        let view = UIView(frame: .zero)
        let animationView = AnimationView()
        let animation = Animation.named(fileName)
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        
        animationView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        animationView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        
        return view
        
        
    }
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
    
}



