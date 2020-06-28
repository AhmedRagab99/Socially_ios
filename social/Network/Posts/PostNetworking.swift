//
//  PostNetworking.swift
//  social
//
//  Created by Ahmed Ragab on 6/26/20.
//  Copyright © 2020 Ahmed Ragab. All rights reserved.
//

import Foundation
import Alamofire
enum PostNetworking{
    case getAllPosts
    case getMyPosts
    case createPost(text:String,imgageUrl:String)
    case deletePost(postId:String)
    case getFollowingPosts
    case likePost(postId:String)
    case unlikePost(postId:String)
    case comment(text:String,postId:String)
    case uncomment(text:String,postId:String)
    
    
}


extension PostNetworking:TargetType{
    var baseUrl: String {
        switch self{
        default:
            return Constants.baseUrl
        }
    }
    
    var path: String {
        switch self{
        case .getAllPosts:
            return "/post/all"
        case .getMyPosts:
            return "/post/me"
        case .createPost:
            return "/post/create"
        case .deletePost(let postId):
            return "/post/delete/\(postId)"
        case .getFollowingPosts:
            return "/post/followposts"
        case .likePost:
            return "/post/like"
        case .unlikePost:
            return "/post/unlike"
        case .comment:
            return "/post/comment"
        case .uncomment:
        return "/post/uncomment"
            
        }
    }
    
    var method: HTTPMethod {
        switch self{
        case .getAllPosts,.getMyPosts,.getFollowingPosts:
            return .get
        case .createPost:
            return .post
        case .deletePost:
            return .delete
        case .likePost,.unlikePost,.comment,.uncomment:
            return .put
        }
    }
    
    var task: Task {
        switch self{
        case .getAllPosts,.getMyPosts,.deletePost,.getFollowingPosts:
            return .requestPlain
        case .createPost(let text, let imgageUrl):
            return .requestParameters(parameters: ["text":text,"pic":imgageUrl], encoding: JSONEncoding.default)
        case .likePost(let postId):
            return .requestParameters(parameters: ["postId":postId], encoding: JSONEncoding.default)
        case .unlikePost(let postId):
                   return .requestParameters(parameters: ["postId":postId], encoding: JSONEncoding.default)
            case .comment(let text,let postId):
                return .requestParameters(parameters: ["postId":postId,"text":text], encoding: JSONEncoding.default)
            case .uncomment(let text,let postId):
                           return .requestParameters(parameters: ["postId":postId,"text":text], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self{
        case .getAllPosts:
            return [:]
        case .getMyPosts,.createPost,.deletePost,.getFollowingPosts,.likePost,.unlikePost,.comment,.uncomment:
            return ["Content-Type":"application/json"]
        }
    }
    
    
}
