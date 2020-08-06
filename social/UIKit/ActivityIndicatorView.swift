//
//  ActivityIndicatorView.swift
//  social
//
//  Created by Ahmed Ragab on 7/7/20.
//  Copyright © 2020 Ahmed Ragab. All rights reserved.
//

import Foundation
import SwiftUI

struct ActivityIndicatorView: UIViewRepresentable {
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {}

    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let view = UIActivityIndicatorView(style: .large)
        view.startAnimating()
        return view
    }
}
