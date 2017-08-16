//
//  TimelineTableViewCell.swift
//  Storekeeper
//
//  Created by zengdaqian on 2017/8/16.
//  Copyright © 2017年 zengdaqian. All rights reserved.
//

import UIKit

class TimelineTableViewCell: UITableViewCell {
    
    @IBOutlet weak var identifierView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func config(timeline: Timeline) {
        let type = timeline.type ?? .none
        identifierView.backgroundColor = type == .stockIn ? GlobalDefine.Colors.tint : GlobalDefine.Colors.button
        titleLabel.text = timeline.title
        contentLabel.text = timeline.content
        dateLabel.text = timeline.createdAt?.string(format: .custom("HH:mm"))
    }

}
