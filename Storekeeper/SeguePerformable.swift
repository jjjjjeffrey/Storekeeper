//
//  SeguePerformable.swift
//  tianshidaoyi2
//
//  Created by zengdaqian on 2017/2/22.
//  Copyright © 2017年 zengdaqian. All rights reserved.
//

import Foundation
import UIKit
import SwifterSwift

protocol SeguePerformable {
    func performSegue(withIdentifier identifier: String, sender: Any?)
}

extension SeguePerformable {
    func perform<Segue: RawRepresentable>(segue: Segue, sender: Any?) where Segue.RawValue == String {
        performSegue(withIdentifier: segue.rawValue, sender: self)
    }
}
