//
//  postsObserver.swift
//  social
//
//  Created by Ahmed Ragab on 7/4/20.
//  Copyright © 2020 Ahmed Ragab. All rights reserved.
//

import Foundation
import Combine
import Alamofire


class PostsObserver:ObservableObject{
    
    @Published var postObserver = [Post]()
    @Published var isError = false
    @Published var error = ""
    
    
    
    init() {
        
    }
    
    func getMyPosts(){
        PostApi.shared.getPostsByMe { (result) in
            switch result{
                
            case .success(let responce):
                guard let data = responce?.posts else {return}
                DispatchQueue.main.async {
                    self.postObserver = data
                }
            case .failure(let error):
                self.isError.toggle()
                self.error = error.localizedDescription
                print(error.localizedDescription)
                
            }
        }
    }
    
    
    
    func fetch (){
        PostApi.shared.getAllPosts { (result) in
            
            switch result{
            case .success(let responce):
                print(responce ?? "")
                guard let data = responce?.posts else {return}
                DispatchQueue.main.async {
                    self.postObserver = data
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
}
