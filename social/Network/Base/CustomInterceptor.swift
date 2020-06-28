//
//  CustomInterceptor.swift
//  social
//
//  Created by Ahmed Ragab on 6/26/20.
//  Copyright © 2020 Ahmed Ragab. All rights reserved.
//

import Foundation
import Alamofire

class CustomInterceptor:RequestInterceptor{

    
    
    var  token = UserDefaults.standard.string(forKey: "token")  ?? ""
    

    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
      
        var urlRequest = urlRequest
        guard let urlString = urlRequest.url?.absoluteString else {return}
        if urlString.contains("/post/me") || urlString.contains("/post/create") || urlString.contains("/post/delete") || urlString.contains("/post/followposts") || urlString.contains("/post/like") || urlString.contains("/post/unlike") || urlString.contains("/post/comment") || urlString.contains("/post/uncomment") || urlString.contains("/find") || urlString.contains("/user/follow") || urlString.contains("/user/unfollow") || urlString.contains("/user/all"){
            urlRequest.addValue(token, forHTTPHeaderField: "Authorization")
        }
        completion(.success(urlRequest))
        
    }
    
}
