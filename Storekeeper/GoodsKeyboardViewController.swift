//
//  GoodsKeyboardViewController.swift
//  Storekeeper
//
//  Created by zengdaqian on 2017/8/3.
//  Copyright © 2017年 zengdaqian. All rights reserved.
//

import UIKit
import IBAnimatable
import SwifterSwift

class GoodsKeyboardViewController: AnimatableModalViewController {
    
    enum Status {
        case count, price
    }
    
    enum KeyboardButton {
        case number(Int)
        case dot
        case delete
        case clear
        case confirm
        case none
        
        init(button: UIButton) {
            switch button.tag {
            case 0...9:
                self = .number(button.tag)
            case 10:
                self = .dot
            case 11:
                self = .delete
            case 12:
                self = .clear
            case 13:
                self = .confirm
            default:
                self = .none
            }
        }
    }
    
    var goods: Goods?
    
    var status: Status = .count
    
    var count = "0" {
        didSet {
            countButton.setTitleForAllStates("\(count)\(goods?.unit ?? "")")
        }
    }
    var price = ""
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var countButton: UIButton!
    @IBOutlet weak var priceButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = goods?.name
        countButton.setTitleForAllStates("0\(goods?.unit ?? "")")
        priceButton.setTitleForAllStates("¥ 0.00")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func keyboardButtonClicked(_ sender: UIButton) {
        let bt = KeyboardButton(button: sender)
        
        if status == .count {
            handleCountButtonKeyboard(bt: bt)
        }
    }
    
    @IBAction func countOrPriceButtonClicked(_ sender: UIButton) {
        countButton.isSelected = false
        priceButton.isSelected = false
        
        sender.isSelected = true
        
        if sender == countButton {
            status = .count
        } else {
            status = .price
        }
    }
    
    func handleCountButtonKeyboard(bt: KeyboardButton) {
        switch bt {
        case let .number(n):
            if count.length == 5 { return }
            
            if let f = count.firstCharacter, f == "0" {
                if n != 0 {
                    count = "\(n)"
                }
            } else {
                count += "\(n)"
            }
        case .dot:
            return
        case .delete:
            count.characters = count.characters.dropLast()
            if count.length == 0 { count = "0" }
            return
        case .clear:
            count = "0"
        case .confirm:
            return
        default:
            return
        }
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
