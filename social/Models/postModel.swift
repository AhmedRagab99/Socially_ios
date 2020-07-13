//
//  postModel.swift
//  social
//
//  Created by Ahmed Ragab on 6/26/20.
//  Copyright © 2020 Ahmed Ragab. All rights reserved.
//

import Foundation

// MARK: - PostModel
struct PostModel: Codable {
    var count: Int?
    var posts: [Post]?
    
   
}


// MARK: - Post
struct Post: Codable,Identifiable {
    var pic: String?
    var likes: [String]?
    var id, text: String?
    var user: User?
    var created: String?
    var comments: [Comment]?

    enum CodingKeys: String, CodingKey {
        case pic, likes
        case id = "_id"
        case text, user
        case created = "creteAt"
        case comments
        
    }
}

// MARK: - Comment
struct Comment: Codable,Identifiable {
    var created, id, text: String?
    var userId: User?

    enum CodingKeys: String, CodingKey {
        case created
        case id = "_id"
        case text
        case userId = "postedBy"
    }
}







