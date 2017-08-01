//
//  AddGoodsCategoryViewController.swift
//  Storekeeper
//
//  Created by zengdaqian on 2017/8/1.
//  Copyright © 2017年 zengdaqian. All rights reserved.
//

import UIKit

class AddGoodsCategoryViewController: UITableViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var callback: ((GoodsCategory) -> Void)?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func editingDidChanged(_ sender: Any) {
        saveButton.isEnabled = (textField.text?.length ?? 0) > 0 ? true : false
    }
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        let category = GoodsCategory(id: nil, name: textField.text!)
        callback?(category)
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
