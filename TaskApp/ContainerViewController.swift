//
//  ContainerViewController.swift
//  TaskApp
//
//  Created by Kotaro Suto on 2016/10/08.
//  Copyright © 2016年 Kotaro Suto. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {
    var plusButton : UIButton! = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        plusButton.frame = CGRect(x: self.view.frame.width - 70, y: self.view.frame.height - 70 , width: 60, height: 60)
        plusButton.backgroundColor = UIColor.red
        plusButton.layer.cornerRadius = 30
        plusButton.layer.masksToBounds = true
        plusButton.addTarget(self, action: #selector(ContainerViewController.plusButtonTapped), for:.touchUpInside)
        self.view.addSubview(plusButton)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func plusButtonTapped() {
        print("PPAP")
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
