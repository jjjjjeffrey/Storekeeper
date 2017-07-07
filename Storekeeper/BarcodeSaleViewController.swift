//
//  BarcodeSaleViewController.swift
//  Storekeeper
//
//  Created by zengdaqian on 2017/7/6.
//  Copyright © 2017年 zengdaqian. All rights reserved.
//

import UIKit
import SwiftQRCode

class BarcodeSaleViewController: UIViewController, UITableViewDataSource {
    
    let scanner = QRCode()
    
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = ""
        
        scanner.prepareScan(view) { (stringValue) -> () in
            print(stringValue)
        }
        scanner.scanFrame = view.bounds
    
        tableView.tableFooterView = UIView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // start scan
        scanner.startScan()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = "商品\(indexPath.row+1)"
        cell.detailTextLabel?.text = "¥ 8.00"
        
        
        return cell
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
