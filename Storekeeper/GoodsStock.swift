//
//  GoodsStock.swift
//  Storekeeper
//
//  Created by zengdaqian on 2017/8/8.
//  Copyright © 2017年 zengdaqian. All rights reserved.
//

import Foundation
import HandyJSON

struct GoodsStock: HandyJSON {
    var id: Int?
    var goodsId: Int?
    var count: Int?
    var price: Double?
    var goodsName: String?
}
