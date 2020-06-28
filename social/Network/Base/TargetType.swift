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




