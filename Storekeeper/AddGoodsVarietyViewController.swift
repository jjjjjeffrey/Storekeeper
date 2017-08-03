//
//  AddGoodsVarietyViewController.swift
//  Storekeeper
//
//  Created by zengdaqian on 2017/8/1.
//  Copyright © 2017年 zengdaqian. All rights reserved.
//

import UIKit
import PKHUD

class AddGoodsVarietyViewController: UITableViewController {

    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    
    var category: GoodsCategory? {
        didSet {
            guard let c = category else {
                return
            }
            categoryLabel.text = c.name
            goods.category = c.name
        }
    }
    
    var unit: GoodsUnit? {
        didSet {
            guard let u = unit else {
                return
            }
            unitLabel.text = u.name
            goods.unit = unit?.name
        }
    }
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var barcodeField: UITextField!
    @IBOutlet weak var stockField: UITextField!
    @IBOutlet weak var priceField: UITextField!
    
    
    var goods = Goods()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func editingDidChange(_ sender: UITextField) {
        if sender === nameField, (sender.text?.length ?? 0) > 0 {
            goods.name = nameField.text!
        } else if sender === barcodeField, (sender.text?.length ?? 0) > 0 {
            goods.barCode = barcodeField.text!
        } else if sender === stockField, (sender.text?.length ?? 0) > 0 {
            goods.stock = stockField.text?.int ?? 0
        } else if sender === priceField, (sender.text?.length ?? 0) > 0 {
            goods.sellPrice = priceField.text?.double ?? 0.00
        }
    }
    
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        switch goods.canCreate {
        case (true, _):
            save()
        case let (false, message):
            showErrorHud(message: message)
        }
    }
    
    func save() {
        HUD.show(.progress)
        let req = APIAddGoods(goods: goods)
        httpClient.send(req) { (response) in
            guard let c = response?.code, c == 0 else {
                return self.showErrorHud(message: response?.message ?? "保存失败")
            }
            HUD.flash(.success, delay: 0.7)
            self.navigationController?.popViewController()
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? GoodsCategoriesViewController {
            vc.callback = { c in
                self.category = c
                vc.navigationController?.popViewController()
            }
        } else if let vc = segue.destination as? GoodsUnitsViewController {
            vc.callback = { u in
                self.unit = u
                vc.navigationController?.popViewController()
            }
        }
    }
    

}

extension Goods {
    
    var canCreate: (Bool, String) {
        get {
            guard name != nil else {
                return (false, "名称不能为空")
            }
            guard category != nil else {
                return (false, "请选择分类")
            }
            guard unit != nil else {
                return (false, "请选择单位")
            }
            guard stock != nil else {
                return (false, "初始库存不能为空")
            }
            guard sellPrice != nil else {
                return (false, "售价不能为空")
            }
            
            
            return (true, "")
        }
    }
    
}
