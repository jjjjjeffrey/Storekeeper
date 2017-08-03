//
//  Goods.swift
//  Storekeeper
//
//  Created by zengdaqian on 2017/8/2.
//  Copyright © 2017年 zengdaqian. All rights reserved.
//

import Foundation
import HandyJSON

struct Goods: HandyJSON {
    var id: Int?
    var name: String?
    var barCode: String?
    var category: String?
    var unit: String?
    var stock: Int?
    var sellPrice: Double?
}
