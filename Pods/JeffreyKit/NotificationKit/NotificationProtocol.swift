//
//  Notification.swift
//  JeffreyKit
//
//  Created by zengdaqian on 2016/12/14.
//  Copyright © 2016年 zengdaqian. All rights reserved.
//

import Foundation

public class NotificationCenter {
    
    public static let `default` = NotificationCenter()
    
    private init() {
        
    }
    
    public func send<N: Notification>(notification: N, userInfo aUserInfo: [AnyHashable : Any]? = nil) {
        let name = Foundation.Notification.Name(notification.name)
        
        let notification = Foundation.Notification(name: name, object: self, userInfo: aUserInfo)
        Foundation.NotificationCenter.default.post(notification)
    }
    
    public func addObserver<N: Notification>(observer: Any, object anObject: Any? = nil, for notification: N, selector: Selector) {
        let name = Foundation.Notification.Name(notification.name)
        Foundation.NotificationCenter.default.addObserver(observer, selector: selector, name: name, object: anObject)
    }
    
    public func addObserver<N: Notification>(forNotification notification: N, object obj: Any? = nil, queue: OperationQueue? = nil, using block: @escaping (Foundation.Notification) -> Swift.Void) -> NSObjectProtocol {
        let name = Foundation.Notification.Name(notification.name)
        return Foundation.NotificationCenter.default.addObserver(forName: name, object: obj, queue: queue, using: block)
    }
    
    public func removeObserver<N: Notification>(_ observer: Any, notification: N, object anObject: Any?) {
        let name = Foundation.Notification.Name(rawValue: notification.name)
        Foundation.NotificationCenter.default.removeObserver(observer, name: name, object: anObject)
    }
    
    public func removeObserver(observer: Any) {
        Foundation.NotificationCenter.default.removeObserver(observer)
    }
    
}

public protocol Notification: RawRepresentable {
    var name: String { get }
}

public extension Notification where Self.RawValue == String {
    var name: String {
        return "\(self).\(self.rawValue)"
    }
}






