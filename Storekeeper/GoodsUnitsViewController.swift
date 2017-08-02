//
//  GoodsUnitViewController.swift
//  Storekeeper
//
//  Created by zengdaqian on 2017/7/21.
//  Copyright © 2017年 zengdaqian. All rights reserved.
//

import UIKit
import PKHUD

class GoodsUnitsViewController: UITableViewController {

    var units: [GoodsUnit] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    var callback: ((GoodsUnit) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()
    }
    
    func loadData() {
        HUD.show(.progress)
        let req = APIGoodsUnits()
        httpClient.send(req) { (response) in
            guard let us = response?.data else {
                return self.showErrorHud(message: response?.message ?? "加载失败")
            }
            HUD.hide()
            self.units = us
        }
    }
    
    func create(unit: GoodsUnit, complete: @escaping (Bool) -> Void) {
        HUD.show(.progress)
        let req = APIAddGoodsUnit(unit: unit)
        httpClient.send(req) { (response) in
            guard let u = response?.data else {
                self.showErrorHud(message: response?.message ?? "添加失败")
                return complete(false)
            }
            HUD.hide()
            complete(true)
            self.units.insert(u, at: 0)
        }
    }
    
    func delete(indexPath: IndexPath) {
        HUD.show(.progress)
        let unit = units[indexPath.row]
        let req = APIDeleteGoodsUnit(unit: unit)
        httpClient.send(req) { (response) in
            guard let c = response?.code, c == 0 else {
                return self.showErrorHud(message: response?.message ?? "删除失败")
            }
            HUD.hide()
            self.units.remove(at: indexPath.row)
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
        return units.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        let unit = units[indexPath.row]
        cell.textLabel?.text = unit.name

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let unit = units[indexPath.row]
        callback?(unit)
    }

    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let action = UITableViewRowAction(style: .default, title: "删除") { (action, indexPath) in
            self.delete(indexPath: indexPath)
        }
        return [action]
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? AddGoodsUnitViewController {
            vc.callback = { u in
                self.create(unit: u, complete: { (success) in
                    if success {
                        vc.navigationController?.popViewController()
                    }
                })
            }
        }
    }
    

}
