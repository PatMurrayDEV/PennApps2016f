//
//  CheckMarkButton.swift
//  CheckMarkButton
//
//  Created by apple on 15-4-14.
//  Copyright (c) 2015年 apple.com. All rights reserved.
//

/*
 *  动画主要有三个Layer构成，其中grayCircleLayer是暗红色、静止的
 *  checkMarkLayer 是打钩动画
 *  circleLayer 是转圈动画
 */

import CoreGraphics
import QuartzCore
import UIKit

open class CheckMarkButton: UIButton {
    
    fileprivate let width: CGFloat = 50
    fileprivate let height: CGFloat = 50
    fileprivate let radius: CGFloat = 25
    fileprivate let lineWidth: CGFloat = 4
    
    fileprivate let circleLayer = CAShapeLayer()
    fileprivate let checkMarkLayer = CAShapeLayer()
    fileprivate let grayCircleLayer = CAShapeLayer()
    
    fileprivate let animationDuration = 1.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        commonInit()
    }
    
    fileprivate func commonInit( ){
        
        var x:CGFloat = 0.0
        var y:CGFloat = 0.0
        
        let checkmarkPath = UIBezierPath()
        
        x = radius - radius * sin(0.25 * CGFloat(M_PI))
        y = x
        let startPoint = CGPoint(x: x, y: y)
        checkmarkPath.move(to: startPoint)
        
        x = radius
        y = radius*1.2
        let midPoint = CGPoint(x: x, y: y)
        checkmarkPath.addLine(to: midPoint)
        
        x = radius + radius * sin(0.25 * CGFloat(M_PI))
        y = radius - radius * sin(0.25 * CGFloat(M_PI))
        let endPoint = CGPoint(x: x, y: y)
        checkmarkPath.addLine(to: endPoint)
        
        checkMarkLayer.path = checkmarkPath.cgPath
        checkMarkLayer.lineWidth = lineWidth
        checkMarkLayer.lineCap = kCALineCapRound
        checkMarkLayer.lineJoin = kCALineJoinRound
        checkMarkLayer.fillColor = UIColor.clear.cgColor
        checkMarkLayer.strokeColor = UIColor.black.cgColor
        checkMarkLayer.strokeEnd = 0.0
        checkMarkLayer.strokeStart = 0.0
        layer.addSublayer(checkMarkLayer)
        
        let circlePath = UIBezierPath()
        circlePath.addArc(withCenter: CGPoint(x: width/2, y: height/2), radius: radius, startAngle: 1.25*CGFloat(M_PI), endAngle: 3.25*CGFloat(M_PI), clockwise: false)

        circleLayer.path = circlePath.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeColor = UIColor.black.cgColor
        circleLayer.lineCap = kCALineCapRound
        circleLayer.lineWidth = lineWidth
        
        layer.addSublayer(circleLayer)
        
        
        grayCircleLayer.path = circlePath.cgPath
        grayCircleLayer.fillColor = UIColor.clear.cgColor
        grayCircleLayer.strokeColor = UIColor.black.cgColor
        grayCircleLayer.opacity = 0.4
        grayCircleLayer.lineWidth = lineWidth
        layer.addSublayer(grayCircleLayer)

    }
    
    override open var intrinsicContentSize : CGSize {
        return CGSize(width: width, height: height)
    }
    
    open var showAnimation: Bool = false {
        didSet {
            let circleStrokeStart = CABasicAnimation(keyPath: "strokeStart")
            circleStrokeStart.duration = 0.8 * animationDuration
            circleStrokeStart.beginTime = 0.0
            
            /*
             * 因为是kCALineCapRound，所以toValue需设为1.1，否则会有一个小红点
             */
            
            circleStrokeStart.fromValue = showAnimation ? NSNumber(value: 0.0 as Float) : NSNumber(value: 1.1 as Float)
            circleStrokeStart.toValue   = showAnimation ? NSNumber(value: 1.1 as Float) : NSNumber(value: 0.0 as Float)
            circleStrokeStart.isRemovedOnCompletion = false
            circleStrokeStart.fillMode = kCAFillModeForwards
            
            let checkMarkAnimationGroup = CAAnimationGroup()
            checkMarkAnimationGroup.isRemovedOnCompletion = false
            checkMarkAnimationGroup.fillMode = kCAFillModeForwards
            checkMarkAnimationGroup.duration = animationDuration
            checkMarkAnimationGroup.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
            
            circleLayer.add(circleStrokeStart, forKey: "checkLayerAnimation")
            
            let markStrokeEnd = CAKeyframeAnimation(keyPath: "strokeEnd")
            markStrokeEnd.duration = 0.8 * animationDuration
            markStrokeEnd.isRemovedOnCompletion = false
            markStrokeEnd.fillMode = kCAFillModeForwards
            markStrokeEnd.calculationMode = kCAAnimationPaced
            markStrokeEnd.values = showAnimation ? [0.0,0.85] : [0.85,0.0]
            
            let markStrokeStart = CAKeyframeAnimation(keyPath: "strokeStart")
            markStrokeStart.duration = 0.3 * animationDuration
            markStrokeStart.isRemovedOnCompletion = false
            markStrokeStart.fillMode = kCAFillModeForwards
            markStrokeStart.values = showAnimation ? [0.0,0.3] : [0.3,0.0]
            if showAnimation {
                markStrokeStart.beginTime = 0.6 * animationDuration
            }
            
            checkMarkAnimationGroup.animations = [markStrokeEnd,markStrokeStart]
            
            checkMarkLayer.add(checkMarkAnimationGroup, forKey: "checkMarkAnimation")
        }
    }
}
