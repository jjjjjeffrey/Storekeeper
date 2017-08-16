//
//  Global.swift
//  tianshidaoyi2
//
//  Created by zengdaqian on 2017/2/15.
//  Copyright © 2017年 zengdaqian. All rights reserved.
//

import Foundation
import UIKit
import SwifterSwift
import FileKit
import JeffreyKit
import HandyJSON

typealias NotificationCenter = JeffreyKit.NotificationCenter
typealias Notification = JeffreyKit.Notification

struct GlobalDefine {
    struct Colors {
        static var main = UIColor(hex: 0x4990e2)
        static var button = UIColor(hex: 0xFF2D55)
        static var tint = UIColor(hex: 0xFF9500)
    }
    
    struct Paths {
        static var sqlite = Path.userDocuments + "/sqlite"
    }
    
    struct HttpClients {
        static let app = AlamofireClient(host: "http://192.168.199.124:8080")
        static let amap = AlamofireClient(host: "http://restapi.amap.com")
    }
    
    
}
