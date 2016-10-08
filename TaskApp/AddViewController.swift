//
//  AddViewController.swift
//  TaskApp
//
//  Created by Kotaro Suto on 2016/10/08.
//  Copyright © 2016年 Kotaro Suto. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {
    
    var cancelButton : UIButton = UIButton()
    @IBOutlet var titleTextField : UITextField? = UITextField()
    @IBOutlet var detailTextView : UITextView? = UITextView()

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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
