//
//  RootViewController.swift
//  TaskApp
//
//  Created by Kotaro Suto on 2016/09/24.
//  Copyright © 2016年 Kotaro Suto. All rights reserved.
//

import UIKit

class RootViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet var table:UITableView!
    var customCell: CustomCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.table.delegate = self
        self.table.dataSource = self
        self.table.rowHeight = 293
        //self.table.rowHeight = UITableViewAutomaticDimension
        let nib = UINib(nibName: "CustomCell", bundle: nil)
        table.register(nib, forCellReuseIdentifier: "Cell")
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Table View Controller
    //Table Viewのセルの数を指定
    func tableView(_ table: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    //各セルの要素を設定する
    func tableView(_ table: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // tableCell の ID で UITableViewCell のインスタンスを生成
        let cell = table.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomCell
        //cell.c
        return cell
    }

}
