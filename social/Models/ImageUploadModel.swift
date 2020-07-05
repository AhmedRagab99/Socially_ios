//
//  ImageUploadModel.swift
//  social
//
//  Created by Ahmed Ragab on 7/5/20.
//  Copyright © 2020 Ahmed Ragab. All rights reserved.
//

import Foundation
// MARK: - ImageUploadModel
struct ImageUploadModel: Codable {
    var data: DataClass?
    var success: Bool?
    var status: Int?
}

// MARK: - DataClass
struct DataClass: Codable {
    var id: String?
    var datetime: Int?
    var type, deletehash, name: String?
    var link: String?
}
