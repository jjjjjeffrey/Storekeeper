//
//  GoodsSelectViewController.swift
//  Storekeeper
//
//  Created by zengdaqian on 2017/7/13.
//  Copyright © 2017年 zengdaqian. All rights reserved.
//

import UIKit

class GoodsSelectViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "商品选择"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension GoodsSelectViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SomeLongIdentifierCell", for: indexPath)
        return cell
    }
    
}

extension GoodsSelectViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //解决cell点击事件延迟的bug
        tableView.deselectRow(at: indexPath, animated: false)
        
        
    }
    
}
