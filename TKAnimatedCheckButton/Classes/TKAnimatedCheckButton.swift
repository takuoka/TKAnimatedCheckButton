//
//  TKAnimatedCheckButton.swift
//  TKAnimatedCheckButton
//
//  Created by Takuya Okamoto on 2015/08/06.
//  Copyright (c) 2015年 Uniface. All rights reserved.

// Inspired by
//http://robb.is/working-on/a-hamburger-button-transition/
//https://dribbble.com/shots/1631598-On-Off


import Foundation
import CoreGraphics
import QuartzCore
import UIKit


class TKAnimatedCheckButton : UIButton {
    
    var shape: CAShapeLayer! = CAShapeLayer()
    
    let path: CGPath = {
        let p = CGPathCreateMutable()
        CGPathMoveToPoint(p, nil, 5.07473346,20.2956615)
        CGPathAddCurveToPoint(p, nil, 3.1031115,24.4497281, 2,29.0960413, 2,34)
        CGPathAddCurveToPoint(p, nil, 2,51.673112, 16.326888,66, 34,66)
        CGPathAddCurveToPoint(p, nil, 51.673112,66, 66,51.673112, 66,34)
        CGPathAddCurveToPoint(p, nil, 66,16.326888, 51.673112,2, 34,2)
        CGPathAddCurveToPoint(p, nil, 21.3077047,2, 10.3412842,9.38934836, 5.16807419,20.1007094)
        CGPathAddLineToPoint(p, nil, 29.9939289,43.1625671)
        CGPathAddLineToPoint(p, nil, 56.7161293,17.3530369)
        return p
    }()
    
    let pathSize:CGFloat = 70
    
    let circleStrokeStart: CGFloat = 0.0
    let circleStrokeEnd: CGFloat = 0.738
    
    let checkStrokeStart: CGFloat = 0.8
    let checkStrokeEnd: CGFloat = 0.97
    
    let opacity:CGFloat = 0.4
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        let defaultPoint = self.frame.origin
        
        var size = frame.width
        if frame.width < frame.height {
            size = frame.height
        }
        let scale:CGFloat = size / pathSize

        self.frame.size = CGSize(width: pathSize, height: pathSize)
        
        self.shape.path = path
        let circle = CAShapeLayer()
        circle.path = path
        let check = CAShapeLayer()
        check.path = path
        
        self.shape.strokeColor = UIColor.whiteColor().CGColor
        circle.strokeColor = UIColor.whiteColor().colorWithAlphaComponent(opacity).CGColor
        check.strokeColor = circle.strokeColor

        self.shape.position = CGPointMake(pathSize/2, pathSize/2)
        circle.position = self.shape.position
        check.position = self.shape.position

        self.shape.strokeStart = circleStrokeStart
        self.shape.strokeEnd = circleStrokeEnd
        circle.strokeStart = circleStrokeStart
        circle.strokeEnd = circleStrokeEnd
        check.strokeStart = checkStrokeStart
        check.strokeEnd = checkStrokeEnd

        for layer in [ self.shape, circle, check] {
            layer.fillColor = nil
            layer.lineWidth = 4
            layer.miterLimit = 4
            layer.lineCap = kCALineCapRound
            layer.masksToBounds = true

            let strokingPath:CGPath = CGPathCreateCopyByStrokingPath(layer.path, nil, 4, kCGLineCapRound, kCGLineJoinMiter, 4)
            layer.bounds = CGPathGetPathBoundingBox(strokingPath)
            layer.actions = [
                "strokeStart": NSNull(),
                "strokeEnd": NSNull(),
                "transform": NSNull()
            ]
            self.layer.transform = CATransform3DMakeScale(scale, scale, 1);
            self.layer.addSublayer(layer)
        }
        self.frame.origin = defaultPoint
    }
    
    var checked: Bool = false {
        didSet {
            let timingFunc = CAMediaTimingFunction(controlPoints: 0.69,0.12,0.23,1.27)
            let strokeStart = CABasicAnimation(keyPath: "strokeStart")
            let strokeEnd = CABasicAnimation(keyPath: "strokeEnd")
            if self.checked {
                strokeStart.toValue = checkStrokeStart
                strokeStart.duration = 0.5
                strokeStart.timingFunction = timingFunc
                
                strokeEnd.toValue = checkStrokeEnd
                strokeEnd.duration = 0.6
                strokeEnd.timingFunction = timingFunc
            } else {
                strokeStart.toValue = circleStrokeStart
                strokeStart.duration = 0.5
                strokeStart.timingFunction = CAMediaTimingFunction(controlPoints: 0.25, 0, 0.5, 1.2)
                strokeStart.beginTime = CACurrentMediaTime() + 0.1
                strokeStart.fillMode = kCAFillModeBackwards
                
                strokeEnd.toValue = circleStrokeEnd
                strokeEnd.duration = 0.6
                strokeEnd.timingFunction = CAMediaTimingFunction(controlPoints: 0.25, 0.3, 0.5, 0.9)
            }
            self.shape.ocb_applyAnimation(strokeStart)
            self.shape.ocb_applyAnimation(strokeEnd)
        }
    }
}

extension CALayer {
    func ocb_applyAnimation(animation: CABasicAnimation) {
        let copy = animation.copy() as! CABasicAnimation
        if copy.fromValue == nil {
            copy.fromValue = self.presentationLayer().valueForKeyPath(copy.keyPath)
        }
        self.addAnimation(copy, forKey: copy.keyPath)
        self.setValue(copy.toValue, forKeyPath:copy.keyPath)
    }
}
