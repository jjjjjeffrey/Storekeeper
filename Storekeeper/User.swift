//
//  User.swift
//  tianshidaoyi2
//
//  Created by zengdaqian on 2016/12/13.
//  Copyright © 2016年 zengdaqian. All rights reserved.
//

import Foundation
import HandyJSON

struct User: HandyJSON {
    var id: Int?
    var shopName: String?
    var mobile: String?
    var token: String?
}

extension User {
    
    static var isLogined: Bool {
        get {
            return currentUser != nil
        }
    }
    
    static var currentUser: User? {
        didSet {
            if let json = currentUser?.toJSONString() {
                AppValueCache.user.set(value: json)
            }
        }
    }
    
    static func initialize() {
        if let json = AppValueCache.user.value() as? String, let user = JSONDeserializer<User>.deserializeFrom(json: json) {
            self.currentUser = user
        }
    }
    
    static func removeCurrentUser() {
        self.currentUser = nil
        AppValueCache.user.remove()
    }
    
}
