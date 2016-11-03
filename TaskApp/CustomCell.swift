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
    @IBOutlet var deleteButton : UIButton?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        customBackgroundView?.layer.cornerRadius = 10.0
        customBackgroundView?.layer.masksToBounds = false
        customBackgroundView?.layer.shadowColor = UIColor.black.cgColor
        customBackgroundView?.layer.shadowOpacity = 0.5
        customBackgroundView?.layer.shadowOffset = CGSize(width: 2, height: 2)
        customDetailTextView?.isEditable = false
        deleteButton?.layer.cornerRadius = 15
        deleteButton?.layer.masksToBounds = false
//        deleteButton?.layer.shadowColor = UIColor.black.cgColor
//        deleteButton?.layer.shadowOpacity = 0.5
//        deleteButton?.layer.shadowOffset = CGSize(width: 2, height: 2)
        deleteButton?.isHidden = true

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func deleteButtonTapped(sender:UIButton) {
        print("ppppp")
        let tableView = superview?.superview as! UITableView //UITableViewを取得
        let tappedIndexPath = tableView.indexPath(for: self) //自分のIndexPathを取得
        let tappedRow = tappedIndexPath?.row //IndexPathから行を取得
        let rootViewContorller = RootViewController()
        //let tableView = rootViewContorller.table
        // IndexPathを取得 (押されたボタンが乗っているCellから)
        //let cell = sender.superview?.superview as? UITableViewCell
        //let indexPath = tableView?.indexPath( for: cell! )
        //print(cell,indexPath)
        print("AAAA -> \(tappedRow!)")
        rootViewContorller.deleteCell(indexPath:tappedIndexPath!)
    }
    
}
