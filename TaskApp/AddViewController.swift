//
//  AddViewController.swift
//  TaskApp
//
//  Created by Kotaro Suto on 2016/10/08.
//  Copyright © 2016年 Kotaro Suto. All rights reserved.
//

import UIKit

class AddViewController: UIViewController,UITextFieldDelegate {
    
    var cancelButton : UIButton = UIButton()
    @IBOutlet var titleTextField : UITextField? = UITextField()
    @IBOutlet var detailTextView : UITextView? = UITextView()
    @IBOutlet var dateTextField : UITextField? = UITextField()
    @IBOutlet var addButton : UIButton? = UIButton()
    let dateFormatter = DateFormatter()
    
    var arrayOfDataOfPost = [DataOfPost]()
    let userDefaults = UserDefaults.standard
    
    @IBAction func addButtonTapped(){
        let enteredItems : DataOfPost = DataOfPost()
        enteredItems.title = (titleTextField?.text)!
        enteredItems.detail = (detailTextView?.text)!
     
        let dateFromString = dateFormatter.date(from: (dateTextField?.text)!)
        enteredItems.date = dateFromString!
        print("\nタイトル = \(enteredItems.title)\n内容 = \(enteredItems.detail)\n期限 = \(enteredItems.date)")
        print("\nenteredItems.date = \(enteredItems.date)\ndateTextField?.text = \(dateTextField?.text!)\ndateFromString = \(dateFromString)\ndate = \(dateFormatter.string(from: dateFromString!))")
        if enteredItems.title == "" && enteredItems.detail == "" {
            // ① UIAlertControllerクラスのインスタンスを生成
            // タイトル, メッセージ, Alertのスタイルを指定する
            // 第3引数のpreferredStyleでアラートの表示スタイルを指定する
            let alert: UIAlertController = UIAlertController(title: "保存しますか？", message: "入力がありません", preferredStyle:  UIAlertControllerStyle.alert)
            
            // ② Actionの設定
            // Action初期化時にタイトル, スタイル, 押された時に実行されるハンドラを指定する
            // 第3引数のUIAlertActionStyleでボタンのスタイルを指定する
            // OKボタン
            let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:{
                // ボタンが押された時の処理を書く（クロージャ実装）
                (action: UIAlertAction!) -> Void in
                self.arrayOfDataOfPost.append(enteredItems)
                let data = NSKeyedArchiver.archivedData(withRootObject: self.arrayOfDataOfPost) //as Data
                self.userDefaults.set(data, forKey: "DATA")
                self.userDefaults.synchronize()
                print("OK")
            })
            // キャンセルボタン
            let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertActionStyle.cancel, handler:{
                // ボタンが押された時の処理を書く（クロージャ実装）
                (action: UIAlertAction!) -> Void in
                print("Cancel")
            })
            
            // ③ UIAlertControllerにActionを追加
            alert.addAction(cancelAction)
            alert.addAction(defaultAction)
            
            // ④ Alertを表示
            present(alert, animated: true, completion: nil)
        }else{
            arrayOfDataOfPost.append(enteredItems)
            let data = NSKeyedArchiver.archivedData(withRootObject: self.arrayOfDataOfPost)
            userDefaults.set(data, forKey: "DATA")
            userDefaults.synchronize()
            dismiss(animated: true, completion: nil)
        }
        
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateFormatter.locale = NSLocale(localeIdentifier: "ja_JP") as Locale
        dateFormatter.dateFormat = "yyyy/MM/dd"
        
        self.view.backgroundColor = UIColor.blue
        cancelButton.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        cancelButton.backgroundColor = UIColor.clear
        cancelButton.setTitle("×", for: .normal)
        cancelButton.setTitleColor(UIColor.white, for: .normal)
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 50)
        cancelButton.addTarget(self, action: #selector(AddViewController.cancelButtonTapped), for: .touchUpInside)
        self.view.addSubview(cancelButton)
        
        dateTextField?.delegate = self
        dateTextField?.tag = 1
        dateTextField?.text = dateFormatter.string(from: Date())
        
        // 仮のサイズでツールバー生成
        let kbToolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 40))
        kbToolBar.barStyle = UIBarStyle.default  // スタイルを設定
        kbToolBar.sizeToFit()  // 画面幅に合わせてサイズを変更
        // スペーサー
        let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        // 閉じるボタン
        let commitButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(AddViewController.commitButtonTapped))
        kbToolBar.items = [spacer, commitButton]
        titleTextField?.inputAccessoryView = kbToolBar
        detailTextView?.inputAccessoryView = kbToolBar
        dateTextField?.inputAccessoryView = kbToolBar
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let unarchivedData = userDefaults.object(forKey: "DATA")
        if unarchivedData == nil {
            arrayOfDataOfPost = [DataOfPost]()
            print("userDefaults are nil")
        }else{
            arrayOfDataOfPost = NSKeyedUnarchiver.unarchiveObject(with: unarchivedData as! Data) as! [DataOfPost]
            //print(arrayOfDataOfPost[0].title)
        }

    }
    
    func cancelButtonTapped() {
        // ① UIAlertControllerクラスのインスタンスを生成
        // タイトル, メッセージ, Alertのスタイルを指定する
        // 第3引数のpreferredStyleでアラートの表示スタイルを指定する
        let alert: UIAlertController = UIAlertController(title: "画面を閉じますか？", message: "保存されていません", preferredStyle:  UIAlertControllerStyle.alert)
        
        // ② Actionの設定
        // Action初期化時にタイトル, スタイル, 押された時に実行されるハンドラを指定する
        // 第3引数のUIAlertActionStyleでボタンのスタイルを指定する
        // OKボタン
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:{
            // ボタンが押された時の処理を書く（クロージャ実装）
            (action: UIAlertAction!) -> Void in
            self.dismiss(animated: true, completion: nil)
            print("OK")
        })
        // キャンセルボタン
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertActionStyle.cancel, handler:{
            // ボタンが押された時の処理を書く（クロージャ実装）
            (action: UIAlertAction!) -> Void in
            print("Cancel")
        })
        
        // ③ UIAlertControllerにActionを追加
        alert.addAction(cancelAction)
        alert.addAction(defaultAction)
        
        // ④ Alertを表示
        present(alert, animated: true, completion: nil)
    }

    func commitButtonTapped (){
        self.view.endEditing(true)
    }
    // UITextField編集直後に呼ばれるメソッド
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("textFieldDidBeginEditing")
        dateEditing(sender: dateTextField!)
    }

    // 日付を入力する
    func dateEditing(sender: UITextField) {
        print("dateEditing")
        let datePicker            = UIDatePicker()
        datePicker.datePickerMode = UIDatePickerMode.date
        datePicker.locale         = NSLocale(localeIdentifier: "ja_JP") as Locale
        sender.inputView          = datePicker
        datePicker.addTarget(self, action: #selector(AddViewController.datePickerValueChanged), for: UIControlEvents.valueChanged)
    }
    
    // 日付を変更した際にUITextFieldに値を設定する
    func datePickerValueChanged(sender:UIDatePicker) {
        print("datePickerValueChanged")
        let dateFormatter       = DateFormatter()
        dateFormatter.locale    = NSLocale(localeIdentifier: "ja_JP") as Locale!
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateTextField?.text = dateFormatter.string(from: sender.date)
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

//データクラス
class DataOfPost : NSObject, NSCoding{
    var title : String = "タイトル"
    var date : Date = Date()
    var detail : String = "内容"
    
    // ②
    // エンコード関数
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: "TITLE")
        aCoder.encode(date, forKey: "DATE")
        aCoder.encode(detail, forKey: "DETAIL")
    }
    // ③
    // デコード関数
    required init(coder aDecoder: NSCoder) {
        super.init()
        self.title = aDecoder.decodeObject(forKey: "TITLE") as! String
        self.date = aDecoder.decodeObject(forKey: "DATE") as! Date
        self.detail = aDecoder.decodeObject(forKey: "DETAIL") as! String
    }
    override init() {
        super.init()
    }
    //また今度
    //var selectedTags : [String] = [String]()
}
