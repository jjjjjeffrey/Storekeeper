//
//  GoodsSelectViewController.swift
//  Storekeeper
//
//  Created by zengdaqian on 2017/7/13.
//  Copyright © 2017年 zengdaqian. All rights reserved.
//

import UIKit
import SwifterSwift

class GoodsSelectViewController: UIViewController, SeguePerformable {

    enum Segue: String {
        case showGoodsKeyboard
    }
    
    var categories: [GoodsCategory] = [] {
        didSet {
            selectedCategory = categories.item(at: 0)
        }
    }
    
    var selectedCategory: GoodsCategory? {
        didSet {
            if let c = selectedCategory {
                loadGoods(for: c)
                categoryButton.setTitleForAllStates(c.name ?? "")
            }
            
        }
    }
    
    
    var goods: [Goods] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    var selectedGoods: Goods?
    
    
    typealias Success = (Bool) -> Void
    var callback: ((Int, Double, Goods, @escaping Success) -> Void)?
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var categoryButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "商品选择"
        
        loadCategories()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func loadGoods(for category: GoodsCategory) {
        let req = APIGoods(category: category)
        httpClient.send(req) { (response) in
            guard let gs = response?.data else {
                return
            }
            self.goods = gs
        }
    }
    
    func loadCategories() {
        let req = APIGoodsCategories()
        httpClient.send(req) { (response) in
            guard let cs = response?.data else {
                return
            }
            self.categories = cs
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? GoodsCategoryPickerViewController {
            vc.callback = { c in
                self.selectedCategory = c
            }
        } else if let vc = segue.destination as? AddGoodsVarietyViewController {
            vc.callback = { c, g in
                vc.navigationController?.popViewController()
                self.selectedCategory = c
            }
        } else if let vc = segue.destination as? GoodsKeyboardViewController {
            vc.goods = selectedGoods
            vc.callback = { c, p in
                self.callback?(c, p, self.selectedGoods!) { success in
                    if success {
                        self.loadCategories()
                    }
                }
                vc.dismiss(animated: true, completion: nil)
            }
        }
    }
    

}

extension GoodsSelectViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GoodsTableViewCell", for: indexPath)
        
        if let c = cell as? GoodsTableViewCell {
            
            let gs = goods[indexPath.row]
            c.nameLabel.text = gs.name
            c.stockLabel.text = "库存：\(gs.stock ?? 0)\(gs.unit ?? "")"
            
            
        }
        
        
        return cell
    }
    
}

extension GoodsSelectViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedGoods = goods[indexPath.row]
        
        DispatchQueue.main.async {
            self.perform(segue: Segue.showGoodsKeyboard, sender: self)
        }
        
        
    }
    
}
