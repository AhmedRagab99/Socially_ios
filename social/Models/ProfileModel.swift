

struct ProfileModel: Codable {
    var user: WelcomeUser?
    var posts: [Posts]?
}

// MARK: - Post
struct Posts: Codable,Identifiable {
    let pic: String?
    let id, text: String?



    enum CodingKeys: String, CodingKey {
        case pic
        case id = "_id"
        case text
    }
}


// MARK: - WelcomeUser
struct WelcomeUser: Codable {
    let pio: String?
    let pic: String?
    let followers, following: [String]?
    let id, name: String?

    enum CodingKeys: String, CodingKey {
        case pio, pic, followers, following
        case id = "_id"
        case name
    }
}
//
//  profile.swift
//  social
//
//  Created by Ahmed Ragab on 6/28/20.
//  Copyright © 2020 Ahmed Ragab. All rights reserved.
//

//import Foundation
//
//
//
//    struct ProfileModel:Codable {
//        var user:User?
//        var posts:[Post]?
//    }
//    var user:User?
//    var posts:[ProfilePost]?
//
//    enum CodingKeys:String,CodingKey {
//        case user = "user"
//        case posts = "posts"
//
//    }

//
//struct ProfilePost:Codable,Identifiable {
//    let pic: String?
//    let likes: [String]?
//    let id, text: String?
//    let creteAt: String?
//
//}

//// MARK: - Post
//struct Posts: Codable {
//    let pic: String?
//    let likes: [String]?
//    let id, text: String?
//    let user: PostUser?
//    let creteAt: String?
//    let v: Int?
//
//
//    enum CodingKeys: String, CodingKey {
//        case pic, likes
//        case id = "_id"
//        case text, user, creteAt
//        case v = "__v"
//
//    }
//}
//
//
//
//// MARK: - PostUser
//struct PostUser: Codable {
//    let pic: String?
//    let id, name: String?
//
//    enum CodingKeys: String, CodingKey {
//        case pic
//        case id = "_id"
//        case name
//    }
//}
//
//// MARK: - WelcomeUser
//struct WelcomeUser: Codable {
//    let pio: String?
//    let pic: String?
//    let followers, following: [String]?
//    let id, name, createdAt: String?
//
//    enum CodingKeys: String, CodingKey {
//        case pio, pic, followers, following
//        case id = "_id"
//        case name, createdAt
//    }
//}

