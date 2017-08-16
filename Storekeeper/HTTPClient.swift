//
//  HTTPClient.swift
//  tianshidaoyi2
//
//  Created by zengdaqian on 2017/2/15.
//  Copyright © 2017年 zengdaqian. All rights reserved.
//

import Foundation
import Alamofire
import HandyJSON
import FileKit
import JeffreyKit



extension HTTPRequest {
    var headers: [String: String] {
        let token = User.currentUser?.token
        return ["token":  token ?? "null"]
    }
}

extension PaginalHTTPRequest {
    var currentIndex: Int {
        return (parameter["from"] as? Int ?? 0)
    }
    
    var pageSize: Int {
        return 20
    }
    
    mutating func parameterInit() {
        parameter["from"] = 0
        parameter["size"] = pageSize
    }
    
    @discardableResult mutating func nextPage() -> Self {
        parameter["from"] = currentIndex + pageSize
        return self
    }
    
    @discardableResult mutating func renew() -> Self {
        parameterInit()
        return self
    }
}

struct AlamofireClient: Client {
    var host = ""
    
    func send<T: HTTPRequest>(_ r: T, handler: @escaping (T.Response?) -> Void) {
        let url = host.appending(r.path)
        var encoding: ParameterEncoding
        switch r.method {
        case .get, .head, .delete:
            encoding = URLEncoding.default
        default:
            encoding = JSONEncoding.prettyPrinted
        }
        let method = Alamofire.HTTPMethod(rawValue: r.method.rawValue) ?? .get
        Alamofire.request(url, method: method, parameters: r.parameter, encoding: encoding, headers: r.headers).responseString(encoding: String.Encoding.utf8) { (response) in
            if let statusCode = response.response?.statusCode, statusCode == 401 {
                NotificationCenter.default.send(notification: APINotification.http401)
                handler(nil)
            } else if let json = response.result.value, let res = T.Response.decode(with: json) {
                handler(res)
            } else {
                handler(nil)
            }
        }
    }
}
