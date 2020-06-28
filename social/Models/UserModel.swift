//
//  UserModel.swift
//  social
//
//  Created by Ahmed Ragab on 6/27/20.
//  Copyright © 2020 Ahmed Ragab. All rights reserved.
//

import Foundation


struct UserModel:Codable {
    var user:User?
    var token:String?
}


// MARK: - User
struct User: Codable {
    var pic: String?
    var id: String?
    var name: String?
    var email: String?
    var createdAt: String?
    var following:[String]?
    var followers:[String]?

    enum CodingKeys: String, CodingKey {
        case pic
        case id = "_id"
        case name, email, createdAt
        case followers = "followers"
        case following = "following"
    }
}

struct Message:Codable{
    var message:String?
}
