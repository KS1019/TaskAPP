//
//  RootViewController.swift
//  TaskApp
//
//  Created by Kotaro Suto on 2016/09/24.
//  Copyright © 2016年 Kotaro Suto. All rights reserved.
//

import UIKit

class RootViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet var table:UITableView?
    @IBOutlet var editButton : UIBarButtonItem?
    var customCell: CustomCell!
    let defaults = UserDefaults.standard
    var dataArray = [DataOfPost]()
    let formmmater = DateFormatter()
    
    var isTappedEditButton = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        formmmater.locale = NSLocale(localeIdentifier: "ja_JP") as Locale
        formmmater.dateFormat = "yyyy/MM/dd"
        
        self.table?.delegate = self
        self.table?.dataSource = self
        self.table?.rowHeight = 293
        //self.table.rowHeight = UITableViewAutomaticDimension
        let nib = UINib(nibName: "CustomCell", bundle: nil)
        table?.register(nib, forCellReuseIdentifier: "Cell")
        
        table?.reloadData()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print(#function)
        let unarchivedData = defaults.object(forKey: "DATA")
        if unarchivedData == nil {
            dataArray = [DataOfPost]()
            print("defaults are nil")
        } else if unarchivedData != nil {
            dataArray = NSKeyedUnarchiver.unarchiveObject(with: unarchivedData as! Data) as! [DataOfPost]
            self.table?.reloadData()
            print("dataArray => \(dataArray.count)")
        }
        table?.reloadData()
    }
    
    func configureTableView() {
        print(#function)
        table?.dataSource = self
        let unarchivedData = defaults.object(forKey: "DATA")
        if unarchivedData == nil {
            dataArray = [DataOfPost]()
            print("defaults are nil")
        } else if unarchivedData != nil {
            dataArray = NSKeyedUnarchiver.unarchiveObject(with: unarchivedData as! Data) as! [DataOfPost]
            self.table?.reloadData()
            print("dataArray => \(dataArray.count)")
        }
        table?.reloadData()
    }
    
    @IBAction func editButtonTapped() {
        if isTappedEditButton == true {
            editButton?.title = "編集"
            isTappedEditButton = false
            table?.reloadData()
        }else if isTappedEditButton == false {
            editButton?.title = "完了"
            isTappedEditButton = true
            table?.reloadData()
        }
    }
    
    
    // MARK: - Table View Controller
    //Table Viewのセルの数を指定
    func tableView(_ table: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(#function)
        return dataArray.count
    }
    
    //各セルの要素を設定する
    func tableView(_ table: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(#function)
        // tableCell の ID で UITableViewCell のインスタンスを生成
        let cell = table.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomCell
        cell.customDateLabel?.text = formmmater.string(from: dataArray[indexPath.row].date)
        cell.customTitleLabel?.text = dataArray[indexPath.row].title
        cell.customDetailTextView?.text = dataArray[indexPath.row].detail
        
        
        if isTappedEditButton == true {
            
            cell.deleteButton?.isHidden = false
        } else if isTappedEditButton == false {
            cell.deleteButton?.isHidden = true
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        // 削除のとき.
        if editingStyle == UITableViewCellEditingStyle.delete {
            print("削除")
            // 指定されたセルのオブジェクトをmyItemsから削除する.
            dataArray.remove(at: indexPath.row)
            let data = NSKeyedArchiver.archivedData(withRootObject: dataArray) //as Data
            defaults.set(data, forKey: "DATA")
            defaults.synchronize()
            table?.deleteRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.automatic)
            // TableViewを再読み込み.
            table?.reloadData()
        }
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        // 先にデータを更新する
        dataArray.remove(at: indexPath.row)
        // それからテーブルの更新
        table?.deleteRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.fade)
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        print(#function,editing)

        super.setEditing(editing, animated: animated)
        
        table?.setEditing(editing, animated: animated)
        print(editing)
    }
    
    func deleteCell(indexPath: IndexPath) {
        print(#function)
        table?.setEditing(true, animated: true)
        let unarchivedData = defaults.object(forKey: "DATA")
        dataArray = NSKeyedUnarchiver.unarchiveObject(with: unarchivedData as! Data) as! [DataOfPost]

        print("dataArray => \(dataArray)\nindexPath.row => \(indexPath.row)")
        table?.beginUpdates()
        // Cellの削除処理
        dataArray.remove(at: (indexPath.row))
        table?.deleteRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.automatic)
        let data = NSKeyedArchiver.archivedData(withRootObject: dataArray) //as Data
        defaults.set(data, forKey: "DATA")
        defaults.synchronize()
        table?.reloadData()
        print("section: \(indexPath.section) - row: \(indexPath.row)")
//        loadView()
//        viewDidLoad()
        //table?.reloadData()
        table?.endUpdates()
        table?.reloadRows(at: (table?.indexPathsForVisibleRows)!, with: UITableViewRowAnimation.automatic)
        configureTableView()

    }
    

}


