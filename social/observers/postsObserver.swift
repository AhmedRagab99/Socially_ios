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
    @Published var postData = Post()
    @Published var message = Message()

    @Published var isError = false
    @Published var error = ""
    @Published var isLoading = false
    
    
    
    init() {
        
    }
    
    
    func createPost(text:String,imageUrl:String){
        PostApi.shared.createPost(text: text, imageUrl: imageUrl) { (result) in
            self.isLoading = true
            switch result{

            case .success(let responce):
                guard let data = responce else {return}
                DispatchQueue.main.async {
                    self.postData = data
                    self.isLoading.toggle()

                }
            case .failure(let error):
                self.isError.toggle()
                self.isLoading=false
                self.error = error.localizedDescription
                print(error.localizedDescription)
                print(error)
            }
        }
    }
    
    
    func deletePost(postId:String){
           PostApi.shared.deletePost(postId: postId) { (result) in
            self.isLoading = true

               switch result{
                   
               case .success(let responce):
                    guard let data = responce else {return}
                DispatchQueue.main.async {
                                  self.message = data
                                  self.isLoading.toggle()

                              }
                
               case .failure(let error):
                self.isError.toggle()
                           self.isLoading=false
                           self.error = error.localizedDescription
                           print(error.localizedDescription)
                           print(error)
               }
           }
       }
    
    func getFollowingPosts(){
           PostApi.shared.getFollowingPosts{ (result) in
             self.isLoading = true

                      switch result{
                      case .success(let responce):
                          self.isLoading.toggle()
                          guard let data = responce?.posts else {return}
                          DispatchQueue.main.async {
                              self.postObserver = data

                          }
                      case .failure(let error):
                          self.isError.toggle()
                          self.isLoading.toggle()
                          self.error = error.localizedDescription
                          print(error.localizedDescription)
                          
                      }
           }
       }
    
    func getMyPosts(){
        PostApi.shared.getPostsByMe { (result) in
            self.isLoading = true

            switch result{
            case .success(let responce):
                self.isLoading.toggle()
                guard let data = responce?.posts else {return}
                DispatchQueue.main.async {
                    self.postObserver = data

                }
            case .failure(let error):
                self.isError.toggle()
                self.isLoading.toggle()
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
