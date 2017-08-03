//
//  GoodsTableViewCell.swift
//  Storekeeper
//
//  Created by zengdaqian on 2017/8/2.
//  Copyright © 2017年 zengdaqian. All rights reserved.
//

import UIKit

class GoodsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var stockLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
