//
//  CustomCell.swift
//  TaskApp
//
//  Created by Kotaro Suto on 2016/09/24.
//  Copyright © 2016年 Kotaro Suto. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    
    @IBOutlet var customBackgroundView: UIView?
    @IBOutlet var customTitleLabel: UILabel?
    @IBOutlet var customDateLabel: UILabel?
    @IBOutlet var customDetailTextView: UITextView?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        customBackgroundView?.layer.cornerRadius = 10.0
        customBackgroundView?.layer.masksToBounds = true
        customDetailTextView?.isEditable = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
