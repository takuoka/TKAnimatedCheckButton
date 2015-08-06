//
//  ViewController.swift
//  TKAnimatedCheckButton
//
//  Created by Takuya Okamoto on 2015/08/06.
//  Copyright (c) 2015年 Uniface. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var button: TKAnimatedCheckButton! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 0.176471, green: 0.701961, blue: 0.203922, alpha: 1)
        
        self.button = TKAnimatedCheckButton(frame: CGRectMake(133, 133, 54, 54))
        self.button.addTarget(self, action: "toggle:", forControlEvents:.TouchUpInside)
        self.view.addSubview(button)
    }
    func toggle(sender: AnyObject!) {
        self.button.checked = !self.button.checked
    }

    override func preferredStatusBarStyle() -> UIStatusBarStyle  {
        return .LightContent
    }
}