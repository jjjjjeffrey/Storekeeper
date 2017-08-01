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
import CryptoSwift

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
        let md5pass = password.md5()
        parameter = ["mobile": mobile, "password": md5pass]
    }
    
}

struct APISendSMSCode: HTTPRequest {
    
    typealias Response = AppResponse<String>
    
    var path: String = "/smsCode"
    
    let method: HTTPMethod = .post
    var parameter: [String: Any] = [:]
    
    init(mobile: String) {
        parameter = ["mobile": mobile]
    }
    
}

struct APIAuthSMSCode: HTTPRequest {
    
    typealias Response = AppResponse<String>
    
    var path: String = "/authSMSCode"
    
    let method: HTTPMethod = .post
    var parameter: [String: Any] = [:]
    
    init(mobile: String, code: String) {
        parameter = ["mobile": mobile, "code": code]
    }
    
}

struct APIRegister: HTTPRequest {
    
    typealias Response = AppResponse<User>
    
    var path: String = "/register"
    
    let method: HTTPMethod = .post
    var parameter: [String: Any] = [:]
    
    init(mobile: String, shopName: String, password: String) {
        let md5pass = password.md5()
        parameter = ["mobile": mobile, "shopName": shopName, "password": md5pass]
    }
    
}

struct APIGoodsCategories: HTTPRequest {
    
    typealias Response = AppResponse<[GoodsCategory]>
    
    var path: String = "/goodsCategory"
    
    let method: HTTPMethod = .get
    var parameter: [String: Any] = [:]
    
    
}

struct APIAddGoodsCategory: HTTPRequest {
    
    typealias Response = AppResponse<GoodsCategory>
    
    var path: String = "/goodsCategory"
    
    let method: HTTPMethod = .post
    var parameter: [String: Any] = [:]
    
    init(category: GoodsCategory) {
        parameter = category.toJSON() ?? [:]
    }
}

struct APIDeleteGoodsCategory: HTTPRequest {
    
    typealias Response = AppResponse<GoodsCategory>
    
    var path: String = "/goodsCategory"
    
    let method: HTTPMethod = .delete
    var parameter: [String: Any] = [:]
    
    init(category: GoodsCategory) {
        path += "/\(category.id ?? -1)"
    }
}


