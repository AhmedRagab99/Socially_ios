//
//  PostApi.swift
//  social
//
//  Created by Ahmed Ragab on 6/26/20.
//  Copyright © 2020 Ahmed Ragab. All rights reserved.
//

import Foundation

class PostApi: BaseApi<PostNetworking> {
    
    
    static let shared = PostApi()
    
    private override init() {
          
      }
      
    
    
    func getAllPosts(completion:@escaping (Result<PostModel?,NSError>)->Void){
        self.fetchData(target: .getAllPosts, responceClass: PostModel.self) { (result) in
            completion(result)
        }
    }
    
    
    
    func getPostsByMe(completion:@escaping(Result<PostModel?,NSError>)->Void){
        self.fetchData(target: .getMyPosts, responceClass: PostModel.self) { (result) in
            completion(result)
        }
    }
    
    
    
    func getFollowingPosts(completion:@escaping(Result<PostModel?,NSError>)->Void){
        self.fetchData(target: .getFollowingPosts, responceClass: PostModel.self) { (result) in
            completion(result)
        }
    }
    
    
    func likePost(postId:String,completion:@escaping(Result<Post?,NSError>)->Void){
        self.fetchData(target: .likePost(postId: postId),responceClass: Post.self) { (result) in
            completion(result)
        }
    }
    
    func unlikePost(postId:String,completion:@escaping(Result<Post?,NSError>)->Void){
        self.fetchData(target: .unlikePost(postId: postId),responceClass: Post.self) { (result) in
            completion(result)
        }
    }
    
    func comment(text:String,postId:String,completion:@escaping((Result<Post?,NSError>)->Void)){
        self.fetchData(target: .comment(text: text, postId: postId), responceClass: Post.self) { (result) in
              completion(result)
          }
      }
    func uncomment(text:String,postId:String,completion:@escaping((Result<Post?,NSError>)->Void)){
      self.fetchData(target: .uncomment(text: text, postId: postId), responceClass: Post.self) { (result) in
            completion(result)
        }
    }
    
    
    func createPost(text:String,imageUrl:String,completion:@escaping((Result<Post?,NSError>)->Void)){
        self.fetchData(target: .createPost(text: text, imgageUrl: imageUrl), responceClass: Post.self) { (result) in
            completion(result)
        }
    }
    
    func deletePost(postId:String,completion:@escaping((Result<Message?,NSError>)->Void)){
        self.fetchData(target:.deletePost(postId: postId) ,responceClass: Message.self) { (result) in
               completion(result)
           }
       }
    
    
    
    
}
