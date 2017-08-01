//
//  Notifications.swift
//  DeclarationClient
//
//  Created by zengdaqian on 2017/2/23.
//  Copyright © 2017年 zengdaqian. All rights reserved.
//

import Foundation
import JeffreyKit

enum APINotification: String, Notification {
    case http401
}

enum APPNotification: String, Notification {
    case login, logout
}
