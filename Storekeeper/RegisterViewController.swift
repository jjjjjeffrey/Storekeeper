//
//  RegisterViewController.swift
//  Storekeeper
//
//  Created by zengdaqian on 2017/7/27.
//  Copyright © 2017年 zengdaqian. All rights reserved.
//

import UIKit
import PKHUD

class RegisterViewController: UIViewController, SeguePerformable {
    
    enum Segue: String {
        case showNext
    }
    
    @IBOutlet weak var mobileField: UITextField!
    @IBOutlet weak var codeField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    var seconds: UInt64 = 60

    override func viewDidLoad() {
        super.viewDidLoad()

        mobileField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendCodeButtonClicked(_ sender: UIButton) {
        
        guard let mobile = mobileField.text else {
            return
        }
        
        HUD.show(.progress)
        let req = APISendSMSCode(mobile: mobile)
        httpClient.send(req) { (response) in
            guard let res = response, let code = res.code, code == 0 else {
                let m = response?.message ?? "发送失败"
                HUD.flash(.labeledError(title: "提示", subtitle: m), delay: 1.5)
                return
            }
            
            HUD.flash(.labeledSuccess(title: "提示", subtitle: "发送成功"), delay: 1.5)
            sender.isEnabled = false
            self.countDown()
        }
        
    }
    
    @IBAction func editingDidChanged(_ sender: Any) {
        nextButton.isEnabled = (mobileField.text?.length ?? 0)==11 && (codeField.text?.length ?? 0)==4
    }
    
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        HUD.show(.progress)
        let req = APIAuthSMSCode(mobile: mobileField.text!, code: codeField.text!)
        httpClient.send(req) { (response) in
            guard let res = response, let code = res.code, code == 0 else {
                let m = response?.message ?? "验证码无效"
                HUD.flash(.labeledError(title: "提示", subtitle: m), delay: 1.5)
                return
            }
            
            
            HUD.hide()
            self.perform(segue: Segue.showNext, sender: self)
        }
    }
    
    func countDown() {
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            self.seconds -= 1
            let title = "\(self.seconds) 秒"
            self.sendButton.setTitle(title, for: .disabled)
            if self.seconds == 0 {
                self.seconds = 60
                self.sendButton.isEnabled = true
            } else {
                self.countDown()
            }
        }
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? RegisterDoneViewController {
            vc.mobile = mobileField.text
        }
    }
    

}
