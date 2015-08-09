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


public class TKAnimatedCheckButton : UIButton {
    
    public var color = UIColor.whiteColor().CGColor {
        didSet {
            self.shape.strokeColor = color
        }
    }
    public var skeletonColor = UIColor.whiteColor().colorWithAlphaComponent(0.25).CGColor {
        didSet {
            circle.strokeColor = skeletonColor
            check.strokeColor = skeletonColor
        }
    }

    
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


    var shape: CAShapeLayer! = CAShapeLayer()
    var circle: CAShapeLayer! = CAShapeLayer()
    var check: CAShapeLayer! = CAShapeLayer()
    
    let lineWidth:CGFloat = 4
    let lineWidthBold:CGFloat = 5
    
    public required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)

        let defaultPoint = self.frame.origin
        
        var size = frame.width
        if frame.width < frame.height {
            size = frame.height
        }
        let scale:CGFloat = size / pathSize

        self.frame.size = CGSize(width: pathSize, height: pathSize)
        
        self.shape.path = path
        self.circle.path = path
        self.check.path = path
        
        self.shape.strokeColor = color
        self.circle.strokeColor = skeletonColor
        self.check.strokeColor = skeletonColor

        self.shape.position = CGPointMake(pathSize/2, pathSize/2)
        self.circle.position = self.shape.position
        self.check.position = self.shape.position

        self.shape.strokeStart = circleStrokeStart
        self.shape.strokeEnd = circleStrokeEnd
        self.circle.strokeStart = circleStrokeStart
        self.circle.strokeEnd = circleStrokeEnd
        self.check.strokeStart = checkStrokeStart
        self.check.strokeEnd = checkStrokeEnd

        shape.lineWidth = lineWidth
        circle.lineWidth = lineWidth
        check.lineWidth = lineWidthBold
        
        for layer in [ circle, check, self.shape ] {
            layer.fillColor = nil
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

    let timingFunc = CAMediaTimingFunction(controlPoints: 0.44,-0.04,0.64,1.4)//0.69,0.12,0.23,1.27)
    let backFunc = CAMediaTimingFunction(controlPoints: 0.45,-0.36,0.44,0.92)

    public var checked: Bool = false {
        didSet {
            let strokeStart = CABasicAnimation(keyPath: "strokeStart")
            let strokeEnd = CABasicAnimation(keyPath: "strokeEnd")
            let lineWidthAnim = CABasicAnimation(keyPath: "lineWidth")
            if self.checked {
                strokeStart.toValue = checkStrokeStart
                strokeStart.duration = 0.3//0.5
                strokeStart.timingFunction = timingFunc
                
                strokeEnd.toValue = checkStrokeEnd
                strokeEnd.duration = 0.3//0.6
                strokeEnd.timingFunction = timingFunc
                
                lineWidthAnim.toValue = lineWidthBold
                lineWidthAnim.beginTime = 0.2
                lineWidthAnim.duration = 0.1
                lineWidthAnim.timingFunction = timingFunc
            } else {
                strokeStart.toValue = circleStrokeStart
                strokeStart.duration = 0.2//0.5
                strokeStart.timingFunction = backFunc//CAMediaTimingFunction(controlPoints: 0.25, 0, 0.5, 1.2)
//                strokeStart.beginTime = CACurrentMediaTime() + 0.1
                strokeStart.fillMode = kCAFillModeBackwards
                
                strokeEnd.toValue = circleStrokeEnd
                strokeEnd.duration = 0.3//0.6
                strokeEnd.timingFunction = backFunc//CAMediaTimingFunction(controlPoints: 0.25, 0.3, 0.5, 0.9)

                lineWidthAnim.toValue = lineWidth
                lineWidthAnim.duration = 0.1
                lineWidthAnim.timingFunction = backFunc
            }
            self.shape.ocb_applyAnimation(strokeStart)
            self.shape.ocb_applyAnimation(strokeEnd)
            self.shape.ocb_applyAnimation(lineWidthAnim)
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
