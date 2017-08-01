//
//  GoodsCategoryManagementViewController.swift
//  Storekeeper
//
//  Created by zengdaqian on 2017/7/21.
//  Copyright © 2017年 zengdaqian. All rights reserved.
//

import UIKit
import PKHUD

class GoodsCategoryManagementViewController: UITableViewController {

    var categories: [GoodsCategory] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    var callback: ((GoodsCategory) -> Void)?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()
    }
    
    func loadData() {
        let req = APIGoodsCategories()
        httpClient.send(req) { (response) in
            guard let cs = response?.data else {
                return
            }
            self.categories = cs
        }
    }
    
    func create(category: GoodsCategory, complete: @escaping (Bool) -> Void) {
        HUD.show(.progress)
        let req = APIAddGoodsCategory(category: category)
        httpClient.send(req) { (response) in
            guard let c = response?.data else {
                HUD.flash(.labeledError(title: "提示", subtitle: response?.message ?? "添加失败"), delay: 1.5)
                return complete(false)
            }
            HUD.hide()
            complete(true)
            self.categories.insert(c, at: 0)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        let category = categories[indexPath.row]
        cell.textLabel?.text = category.name

        return cell
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = categories[indexPath.row]
        callback?(category)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? AddGoodsCategoryViewController {
            vc.callback = { c in
                self.create(category: c, complete: { (success) in
                    if success {
                        vc.navigationController?.popViewController()
                    }
                })
            }
        }
    }
    

}
