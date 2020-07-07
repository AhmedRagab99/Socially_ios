//
//  LoadingView.swift
//  social
//
//  Created by Ahmed Ragab on 7/7/20.
//  Copyright © 2020 Ahmed Ragab. All rights reserved.
//

import SwiftUI

struct LoadingView: View {
    
    let isLoading: Bool
    let retryAction: (() -> ())?
    
    var body: some View {
        Group {
            if isLoading {
                HStack {
                    Spacer()
                    ActivityIndicatorView()
                    Spacer()
                }
            }
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(isLoading: true, retryAction: nil)
    }
}
