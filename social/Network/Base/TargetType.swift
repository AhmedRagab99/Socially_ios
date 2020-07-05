//
//  TargetType.swift
//  social
//
//  Created by Ahmed Ragab on 6/26/20.
//  Copyright © 2020 Ahmed Ragab. All rights reserved.
//

import Foundation
import Alamofire



enum HTTPMethod:String{
    case get = "GET"
    case post = "POST"
    case put  = "PUT"
    case delete = "DELETE"
}


enum Task {
    case requestPlain
    case requestParameters(parameters:[String:Any],encoding:ParameterEncoding)
}


protocol TargetType{
    
    
    var baseUrl:String{get}
    var path:String{get}
    var method:HTTPMethod{get}
    var task:Task{get}
    var headers:[String:String]?{get}
}


enum ApiError: Error, CustomNSError {
    
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case AuthError
    
    var localizedDescription: String {
        switch self {
        case .apiError: return "Failed to fetch data"
        case .invalidEndpoint: return "Invalid endpoint"
        case .invalidResponse: return "cheack the Fields again"
        case .noData: return "please try agian later"
        case .AuthError: return "forbidden! please log in"
        }
    }
    
    var errorUserInfo: [String : Any] {
        [NSLocalizedDescriptionKey: localizedDescription]
    }
    
}



