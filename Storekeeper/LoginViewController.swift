//
//  LoginViewController.swift
//  Storekeeper
//
//  Created by zengdaqian on 2017/7/26.
//  Copyright © 2017年 zengdaqian. All rights reserved.
//

import UIKit
import PKHUD

class LoginViewController: UIViewController {
    
    @IBOutlet weak var mobileField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    typealias Callback = (_ success: Bool) -> Void
    
    var callback: Callback?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func login() {
        
        guard let mobile = mobileField.text, let password = passwordField.text else {
            return
        }
        
        HUD.show(.progress)
        let req = APILogin(mobile: mobile, password: password)
        httpClient.send(req) { (response) in
            HUD.hide()
            if let code = response?.code, code == 0 {
                if let user = response?.data {
                    User.currentUser = user
                    self.callback?(true)
                }
            } else {
                HUD.flash(.labeledError(title: "发生错误", subtitle: response?.message ?? "Server Error"), delay: 0.7)
            }
            
        }
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField.tag == 100 {
            textField.resignFirstResponder()
            passwordField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            login()
        }
        
        
        return true
    }
    
}
