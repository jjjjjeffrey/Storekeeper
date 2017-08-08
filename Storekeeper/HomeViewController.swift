//
//  HomeViewController.swift
//  Storekeeper
//
//  Created by zengdaqian on 2017/7/12.
//  Copyright © 2017年 zengdaqian. All rights reserved.
//

import UIKit
import Charts
import IBAnimatable
import PKHUD

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var placeholder: UIView!
    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var placeholderImageView: AnimatableImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.isHidden = true
        mainStackView.addArrangedSubview(placeholder)
        tableView.tableFooterView = UIView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        placeholderImageView.animate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? GoodsSelectViewController {
            vc.callback = { c, p, g, callback in
                var stock = GoodsStock()
                stock.count = c
                stock.price = p
                stock.goodsId = g.id
                stock.goodsName = g.name

                HUD.show(.progress)
                let req = APIAddGoodsStock(stock: stock)
                self.httpClient.send(req, handler: { (response) in
                    guard let c = response?.code, c == 0 else {
                        return self.showErrorHud(message: response?.message ?? "保存失败")
                    }
                    callback(true)
                    HUD.flash(.success, delay: 0.7)
                })
            }
            
        }
    }
    

}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ide = indexPath.row == 0 ? "Sale" : "Buy"
        let cell = tableView.dequeueReusableCell(withIdentifier: ide, for: indexPath)
        
        return cell
    }
}
