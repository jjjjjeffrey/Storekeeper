//
//  AddGoodsVarietyViewController.swift
//  Storekeeper
//
//  Created by zengdaqian on 2017/8/1.
//  Copyright © 2017年 zengdaqian. All rights reserved.
//

import UIKit

class AddGoodsVarietyViewController: UITableViewController {

    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    
    var category: GoodsCategory? {
        didSet {
            guard let c = category else {
                return
            }
            categoryLabel.text = c.name
        }
    }
    
    var unit: GoodsUnit? {
        didSet {
            guard let u = unit else {
                return
            }
            unitLabel.text = u.name
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
