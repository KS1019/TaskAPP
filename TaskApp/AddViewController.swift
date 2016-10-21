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
    
    @IBAction func addButtonTapped(){
        let enteredItems : DataOfPost = DataOfPost()
        enteredItems.title = (titleTextField?.text)!
        enteredItems.detail = (detailTextView?.text)!
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "ja_JP") as Locale
        dateFormatter.dateFormat = "yyyy/MM/dd"
        let dateFromString = dateFormatter.date(from: (dateTextField?.text)!)
        enteredItems.date = dateFromString!
        print("\nタイトル = \(enteredItems.title)\n内容 = \(enteredItems.detail)\n期限 = \(enteredItems.date)")
        print("\nenteredItems.date = \(enteredItems.date)\ndateTextField?.text = \(dateTextField?.text!)\ndateFromString = \(dateFromString)\ndate = \(dateFormatter.string(from: dateFromString!))")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    func cancelButtonTapped() {
        dismiss(animated: true, completion: nil)
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
class DataOfPost {
    var title : String = "タイトル"
    var date : Date = Date()
    var detail : String = "内容"
    //また今度
    //var selectedTags : [String] = [String]()
}
