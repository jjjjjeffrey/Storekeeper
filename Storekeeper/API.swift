//
//  APICommodity.swift
//  DeclarationClient
//
//  Created by zengdaqian on 2017/3/29.
//  Copyright © 2017年 zengdaqian. All rights reserved.
//

import Foundation
import HandyJSON
import JeffreyKit

struct AppResponse<T>: JSONDecodable, HandyJSON {
    var code: Int?
    var data: T?
    var message: String?
    
    static func decode(with json: String) -> AppResponse? {
        return JSONDeserializer<AppResponse>.deserializeFrom(json: json)
    }
}

struct APILogin: HTTPRequest {
    
    typealias Response = AppResponse<User>
    
    var path: String = "/login"
    
    let method: HTTPMethod = .post
    var parameter: [String: Any] = [:]
    
    init(mobile: String, password: String) {
        parameter = ["mobile": mobile, "password": password]
    }
    
}



