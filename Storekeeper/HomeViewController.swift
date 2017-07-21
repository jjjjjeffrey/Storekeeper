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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    

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
