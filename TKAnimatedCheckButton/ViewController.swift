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
        view.backgroundColor = UIColor(red: 0.176471, green: 0.701961, blue: 0.203922, alpha: 1)
        
        button = TKAnimatedCheckButton(frame: CGRectMake(0, 0, 70, 70))
        button.center = view.center
        button.addTarget(self, action: "toggle:", forControlEvents:.TouchUpInside)
        view.addSubview(button)
        
        //button.color = UIColor.redColor().CGColor
        //button.skeletonColor = UIColor.blueColor().CGColor
    }
    func toggle(sender: AnyObject!) {
        button.checked = !button.checked
    }

    override func preferredStatusBarStyle() -> UIStatusBarStyle  {
        return .LightContent
    }
}