//
//  GoodsCategoryPickerViewController.swift
//  Storekeeper
//
//  Created by zengdaqian on 2017/7/7.
//  Copyright © 2017年 zengdaqian. All rights reserved.
//

import UIKit
import IBAnimatable

class GoodsCategoryPickerViewController: AnimatableModalViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    var categories: [GoodsCategory] = [] {
        didSet {
            selectedCategory = categories.item(at: 0)
            pickerView.reloadAllComponents()
        }
    }
    
    var selectedCategory: GoodsCategory?
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    
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
    
    @IBAction func doneButtonClicked(_ sender: Any) {
        guard let c = selectedCategory else {
            return
        }
        callback?(c)
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
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let category = categories[row]
        return "\(category.name ?? "")"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCategory = categories[row]
    }
    
    
}
