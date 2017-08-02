//
//  ViewControllerExtensions.swift
//  tianshidaoyi2
//
//  Created by zengdaqian on 2017/2/15.
//  Copyright © 2017年 zengdaqian. All rights reserved.
//

import Foundation
import UIKit
import JeffreyKit
import PKHUD

extension UIViewController {
    
    var httpClient: Client {
        return GlobalDefine.HttpClients.app
    }
    
}

extension UIViewController {
    func fixNavigationItemMargin() {
        let leftSpacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        leftSpacer.width = -10
        navigationItem.leftBarButtonItems?.insert(leftSpacer, at: 0)
        
        let rightSpacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        rightSpacer.width = -10
        navigationItem.rightBarButtonItems?.insert(rightSpacer, at: 0)
    }
}

extension UIViewController {
    
    func showErrorHud(message: String) {
        HUD.flash(.labeledError(title: "提示", subtitle: message), delay: 1.5)
    }
    
}
