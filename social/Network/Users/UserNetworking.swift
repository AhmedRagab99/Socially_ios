//
//  UserNetworking.swift
//  social
//
//  Created by Ahmed Ragab on 6/27/20.
//  Copyright © 2020 Ahmed Ragab. All rights reserved.
//

import Foundation
import Alamofire
enum UserNetworking{
    case getUser(userId:String)
    case followUser(followId:String)
    case unFollowUser(unfollowId:String)
    case allUsers
}


extension UserNetworking:TargetType{
    var baseUrl: String {
        return Constants.baseUrl
    }
    
    var path: String {
        switch self{
        case .getUser(let userId):
            return "/user/find/\(userId)"
        case .followUser:
            return "/user/follow"
        case .unFollowUser:
            return "/user/unfollow"
        case .allUsers:
             return "/user/all"
        }
    }
    
    var method: HTTPMethod {
        switch self{
        case .getUser,.allUsers:
            return .get
        case .followUser,.unFollowUser:
            return .put
        }
    }
    
    var task: Task {
        switch self{
        case .getUser,.allUsers:
            return .requestPlain
        case .followUser(let followId):
            return .requestParameters(parameters: ["followId":followId], encoding: JSONEncoding.default)
            case .unFollowUser(let unfollowId):
                    return .requestParameters(parameters: ["unfollowId":unfollowId], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .getUser,.followUser,.unFollowUser,.allUsers:
            return ["Content-Type":"application/json"]
        }
    }
}
