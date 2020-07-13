//
//  ContentView.swift
//  social
//
//  Created by Ahmed Ragab on 6/26/20.
//  Copyright © 2020 Ahmed Ragab. All rights reserved.
//

import SwiftUI
import Alamofire

struct ContentView: View {
    
    @State private var animationState = false
    @State var test:[Post]?
    var body: some View {
        VStack{
            VStack{
                Button(action: {
                    //self.fetch()
                    self.signIn(email: "test5@test.com", password: "123456")
                    //self.signUp(email: "ahmed@test.com", name: "AhmedRagab", password: "123123", pic: "https://images.pexels.com/photos/736716/pexels-photo-736716.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500")
                    //  self.getMyPosts()
                }) {
                    Text("signIn")
                        .foregroundColor(.green)
                }
                
                
                Button(action: {
                    
                    self.getFollowingPosts()
                }) {
                    Text("following Posts")
                        .foregroundColor(.green)
                }
                
                Button(action: {
                    
//                    self.likePost(postId: "5ef1740e7935bd16c7f5e60e")
                }) {
                    Text("like Posts")
                        .foregroundColor(.green)
                }
                
                Button(action: {
                    
                    self.unlikePost(postId: "5ef1740e7935bd16c7f5e60e")
                }) {
                    Text("unlike Posts")
                        .foregroundColor(.green)
                }
            }
            
            VStack{
                Button(action: {
//                    self.comment(text: "this is one", postId: "5ef1740e7935bd16c7f5e60e")
                    
                }) {
                    Text("comment Posts")
                        .foregroundColor(.green)
                }
                Button(action: {
                    self.uncomment(text: "this is one", postId: "5ef1740e7935bd16c7f5e60e")
                    
                }) {
                    Text("uncomment Posts")
                        .foregroundColor(.green)
                }
                
                Button(action: {
                    self.getUser(userId: "5ef17a742f695817d3836803")
                    
                }) {
                    Text("get user ")
                        .foregroundColor(.green)
                }
                
                
                Button(action: {
                    self.followUser(followId:"5ef17a742f695817d3836803")
                    
                }) {
                    Text("follow user ")
                        .foregroundColor(.green)
                }
                
                Button(action: {
                    self.unFollowUser(unfollowId:"5ef17a742f695817d3836803")
                    
                }) {
                    Text("Unfollow user ")
                        .foregroundColor(.green)
                }
                
                
                Button(action: {
                    self.getAllUsers()
                }) {
                    Text("all user ")
                        .foregroundColor(.green)
                }
                
                
                
                
                Button(action: {
                    //self.fetch()
                    //self.signIn(email: "ahmed@test.com", password: "123123")
                    //self.signUp(email: "ahmed@test.com", name: "AhmedRagab", password: "123123", pic: "https://images.pexels.com/photos/736716/pexels-photo-736716.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500")
                    self.createPost(text: "Amazing post again and again", imageUrl: "https://cdn.pixabay.com/photo/2020/06/15/17/35/me-nots-5302712__480.jpg")
                }) {
                    Text("createPost")
                        .foregroundColor(.green)
                }
                
                Button(action: {
                    //self.fetch()
                    //self.signIn(email: "ahmed@test.com", password: "123123")
                    //self.signUp(email: "ahmed@test.com", name: "AhmedRagab", password: "123123", pic: "https://images.pexels.com/photos/736716/pexels-photo-736716.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500")
                    self.deletePost(postId: "5ef7f2b9ff74080f639e5a1f")
                }) {
                    Text("deletePost")
                        .foregroundColor(.green)
                }
                
                Button(action: {
                    //self.fetch()
                    //self.signIn(email: "ahmed@test.com", password: "123123")
                    //self.signUp(email: "ahmed@test.com", name: "AhmedRagab", password: "123123", pic: "https://images.pexels.com/photos/736716/pexels-photo-736716.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500")
                    self.getMyPosts()
                }) {
                    Text("getPost")
                        .foregroundColor(.green)
                }
            }
        }
    }
    
    
    
    //MARK:- User functions
    
    
    
    
    func getAllUsers(){
        UserApi.shared.allUsers { (result) in
            switch result{
                
            case .success(let r):
                print(r)
            case .failure(let err):
                print(err)
            }
        }
    }
    func followUser(followId:String){
        UserApi.shared.followUser(followId: followId) { (result) in
            switch result{
                
            case .success(let r):
                print(r)
            case .failure(let err):
                print(err)
            }
        }
    }
    func unFollowUser(unfollowId:String){
        UserApi.shared.unFollowUser(unfollowId: unfollowId) { (result) in
            switch result{
                
            case .success(let r):
                print(r)
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func getUser(userId:String){
        UserApi.shared.getUser(userId: userId) { (result) in
            switch result{
                
            case .success(let r):
                print(r)
            case .failure(let err):
                print(err)
            }
        }
    }
    //MARK:- Post functions
   
    
    func unlikePost(postId:String){
        PostApi.shared.unlikePost(postId: postId) { (result) in
            switch result{
            case.success(let r):
                print(r)
            case .failure(let err):
                print(err)
            }
        }
    }
    
    
    func uncomment(text:String,postId:String){
        PostApi.shared.uncomment(text: text, postId:postId) { (result) in
            switch result{
                
            case .success(let r):
                print(r)
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func deletePost(postId:String){
        PostApi.shared.deletePost(postId: postId) { (result) in
            switch result{
                
            case .success(let r):
                print(r)
            case .failure(let err):
                print(err)
            }
        }
    }
    
    
    func createPost(text:String,imageUrl:String){
        PostApi.shared.createPost(text: text, imageUrl: imageUrl) { (result) in
            switch result{
                
            case .success(let r):
                print(r)
            case .failure(let err):
                print(err)
            }
        }
    }
    
    
//    func fetch (){
//        PostApi.shared.getAllPosts { (result) in
//            
//            switch result{
//                
//            case .success(let responce):
//                print(responce ?? "")
//                self.test = responce?.posts
//                
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
//    
    
    func getMyPosts(){
        PostApi.shared.getPostsByMe { (result) in
            switch result{
                
            case .success(let responce):
                print(responce)
            case .failure(let error):
                // print(error.localizedDescription)
                print(error)
            }
        }
    }
    
    
    func getFollowingPosts(){
        PostApi.shared.getFollowingPosts{ (result) in
            switch result{
                
            case .success(let responce):
                print(responce!)
            case .failure(let error):
                // print(error.localizedDescription)
                print(error)
            }
        }
    }
    
    
    //MARK:- Auth functions
    func signIn(email:String,password:String){
        AuthApi.shared.signIn(email: email, password: password) { (result) in
            switch result{
                
            case .success(let responce ):
                print(responce ?? "")
                guard let token = responce?.token else {return}
                UserDefaults.standard.setValue("Bearer \(token)", forKeyPath: "token")
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    
    
    func signUp(email:String,name:String,password:String,pic:String){
        AuthApi.shared.signUp(email: email, name: name, picuture: pic, password: password) { (result) in
            switch result{
                
            case .success(let responce):
                print(responce)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
