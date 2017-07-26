//
//  Cache.swift
//  tianshidaoyi2
//
//  Created by zengdaqian on 2016/12/13.
//  Copyright © 2016年 zengdaqian. All rights reserved.
//

import Foundation


enum AppValueCache: String, KeyValueStore {
    case user
}

protocol KeyValueStore {
    func set(value: Any)
    func remove()
    func value() -> Any?
}

extension KeyValueStore where Self: RawRepresentable, Self.RawValue == String {
    
    var key: String {
        return "\(Self.self).\(self.rawValue)"
    }
    
    func set(value: Any) {
        UserDefaults.standard.set(value, forKey: self.key)
    }
    
    func remove() {
        UserDefaults.standard.removeObject(forKey: self.key)
    }
    
    func value() -> Any? {
        return UserDefaults.standard.object(forKey: self.key)
    }
}
