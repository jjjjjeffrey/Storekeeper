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
    var price = "" {
        didSet {
            priceButton.setTitleForAllStates("¥ \(Double(price) ?? 0.00)")
        }
    }
    
    var callback: ((Int, Double) -> Void)?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var countButton: UIButton!
    @IBOutlet weak var priceButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = goods?.name
        countButton.setTitleForAllStates("0\(goods?.unit ?? "")")

        
        
        
        price = "\(goods?.sellPrice ?? 0.00)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func keyboardButtonClicked(_ sender: UIButton) {
        let bt = KeyboardButton(button: sender)
        
        if status == .count {
            handleCountButtonKeyboard(bt: bt)
        } else {
            handlePriceButtonKeyboard(bt: bt)
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
            confirmButtonClicked()
        default:
            return
        }
    }
    
    func handlePriceButtonKeyboard(bt: KeyboardButton) {
        switch bt {
        case let .number(n):
            let new = price + "\(n)"
            guard new.isPrice else {
                return
            }
            
            guard Double(new) ?? 0.00 < 1000000.00 else {
                return
            }
            price = new
        case .dot:
            let new = price + "."
            guard new.isPrice else {
                return
            }
            price = new
        case .delete:
            var new = String(price.characters.dropLast())
            guard new.length > 0 else {
                return price = ""
            }
            if let dot = new.characters.last, dot == "." {
                new = String(new.characters.dropLast())
            }
            
            guard new.isPrice else {
                return
            }
            price = new
        case .clear:
            price = ""
        case .confirm:
            confirmButtonClicked()
        default:
            return
        }
    }
    
    func confirmButtonClicked() {
        guard let c = Int(count), c != 0 else {
            return showErrorHud(message: "请输入数量")
        }
        guard let p = Double(price), p != 0.00 else {
            return showErrorHud(message: "请输入价格")
        }
        
        callback?(c, p)
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

extension String {
    
    var isPrice: Bool {
        get {
            guard let _ = Double(self) else {
                return false
            }
            
            let parts = self.components(separatedBy: ".")
            if parts.count > 1 {
                let part2 = parts[1]
                if part2.characters.count > 2 {
                    return false
                }
            }
            
            return true
        }
    }
    
}
