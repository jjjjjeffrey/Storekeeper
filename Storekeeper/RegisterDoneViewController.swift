//
//  RegisterDoneViewController.swift
//  Storekeeper
//
//  Created by zengdaqian on 2017/7/27.
//  Copyright © 2017年 zengdaqian. All rights reserved.
//

import UIKit
import PKHUD

class RegisterDoneViewController: UIViewController {

    @IBOutlet weak var shopNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var doneButton: UIButton!
    
    var mobile: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        shopNameField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func editingChanged(_ sender: Any) {
        doneButton.isEnabled = (shopNameField.text?.length ?? 0)>0 && (passwordField.text?.length ?? 0)>=6
    }
    
    
    
    
    @IBAction func doneButtonClicked(_ sender: Any) {
        HUD.show(.progress)
        let req = APIRegister(mobile: mobile, shopName: shopNameField.text!, password: passwordField.text!)
        httpClient.send(req) { (response) in
            guard let res = response, let code = res.code, code == 0 else {
                let m = response?.message ?? "注册失败"
                HUD.flash(.labeledError(title: "提示", subtitle: m), delay: 1.5)
                return
            }
            HUD.flash(.labeledSuccess(title: "提示", subtitle: "注册成功"), delay: 1.5)
            self.navigationController?.popToRootViewController(animated: true)
            
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

extension RegisterDoneViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag == 100 {
            shopNameField.resignFirstResponder()
            passwordField.becomeFirstResponder()
        } else {
            passwordField.resignFirstResponder()
        }

        return true
    }
    
}


