//
//  Network.swift
//  JeffreyKit
//
//  Created by zengdaqian on 2016/12/13.
//  Copyright © 2016年 zengdaqian. All rights reserved.
//

import Foundation

public enum HTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}

public protocol HTTPRequest {
    var path: String { get set }
    var method: HTTPMethod { get }
    var parameter: [String: Any] { get set }
    var headers: [String: String] { get }
    
    associatedtype Response: JSONDecodable
}

public protocol PaginalHTTPRequest: HTTPRequest {
    var currentIndex: Int { get }
    var pageSize: Int { get }
    
    mutating func parameterInit()
    mutating func nextPage() -> Self
    mutating func renew() -> Self
}

public protocol JSONDecodable {
    static func decode(with json: String) -> Self?
}

public protocol Client {
    var host: String { get set }
    
    init()
    init(host: String)
    
    func send<T: HTTPRequest>(_ r: T, handler: @escaping (T.Response?) -> Void)
}

public extension Client {
    init(host: String) {
        self.init()
        self.host = host
    }
}
