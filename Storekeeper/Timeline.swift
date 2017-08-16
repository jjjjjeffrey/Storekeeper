//
//  Timeline.swift
//  Storekeeper
//
//  Created by zengdaqian on 2017/8/16.
//  Copyright © 2017年 zengdaqian. All rights reserved.
//

import Foundation
import HandyJSON
import SwiftDate

struct Timeline: HandyJSON {
    var title: String?
    var content: String?
    var type: TimelineType?
    var createdAt: Date?
    
    enum TimelineType: Int {
        case none = -1
        case stockIn
        case sale
    }

}

extension Timeline {
    mutating func mapping(mapper: HelpingMapper) {
        mapper <<<
            self.type <-- TransformOf<TimelineType, Int>(fromJSON: { (rawInt) -> TimelineType? in
                let type = TimelineType(rawValue: rawInt ?? -1)
                return type
            }, toJSON: { type -> Int? in
                return type?.rawValue
            })
        
        mapper <<<
            self.createdAt <-- TransformOf<Date, String>(fromJSON: Date.fromJSON, toJSON: Date.toJSON)
    }
}

extension Date {
    
    static var fromJSON: (String?) -> Date? {
        get {
            return { (rawString) -> Date? in
                let date = rawString?.date(format: .iso8601Auto)?.absoluteDate
                return date
            }
        }
    }
    static var toJSON: (Date?) -> String? {
        get {
            return { date -> String? in
                return date?.string(format: .iso8601Auto)
            }
        }
    }
    
}
