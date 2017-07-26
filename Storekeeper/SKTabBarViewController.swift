//
//  SKTabBarViewController.swift
//  Storekeeper
//
//  Created by zengdaqian on 2017/7/26.
//  Copyright © 2017年 zengdaqian. All rights reserved.
//

import UIKit

class SKTabBarViewController: UITabBarController, SeguePerformable {

    enum Segue: String {
        case showDetail
        case showLogin
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        verifyLogin()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func verifyLogin() {
        if User.isLogined == false {
            perform(segue: Segue.showLogin, sender: self)
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nav = segue.destination as? UINavigationController {
            if let vc = nav.topViewController as? LoginViewController {
                vc.callback = { success in
                    if success {
                        nav.dismiss(animated: true, completion: nil)
                    }
                }
            }
        }
    }
    

}
