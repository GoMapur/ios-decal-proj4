//
//  LineAnimationView.swift
//  Guess Correlation Plus
//
//  Created by Mingjian Lu on 4/25/16.
//  Copyright © 2016 Capur. All rights reserved.
//

import UIKit

class LineAnimationView: UIView {
    
    var currentPoints: [(CGFloat, CGFloat)]?
    // True means no need to have a line transition animation
    var finished = true
    var curIndex = 0
    var lastAlpha: CGFloat = 0.0
    var lastBeta: CGFloat = 0.0
    var stepCount: Int?
    var totalStep = 200

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    init(){
        super.init(frame: CGRectZero)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    func setup() {
        self.backgroundColor = UIColor.clearColor()
        self.tintColor = UIColor.clearColor()
        lastAlpha = self.bounds.height/2.0
    }
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        drawCorrelationLine(rect)
    }
    
    func drawCorrelationLine(rect: CGRect) {
        if currentPoints == nil || curIndex < 1 {
            finished = true
            return
        }
        let (a, b) = DataKit.findAlphaAndBeta(Array<(CGFloat, CGFloat)>(self.currentPoints![0...curIndex]))
        if stepCount == totalStep {
            finished = true
            lastAlpha = a
            lastBeta = b
        }
        
        let bezierPath = UIBezierPath()
        
        let maxYIntsectNowPart = (a+b*rect.maxX)*CGFloat(stepCount!)/CGFloat(totalStep)
        let maxYIntsectPastPart = (lastAlpha+lastBeta*rect.maxX)*(CGFloat(1.0)-CGFloat(stepCount!)/CGFloat(totalStep))
        bezierPath.moveToPoint(CGPoint(x: rect.maxX, y: maxYIntsectNowPart+maxYIntsectPastPart))
        
        let minYIntsectNowPart = (a+b*rect.minX)*CGFloat(stepCount!)/CGFloat(totalStep)
        let minYIntsectPastPart = (lastAlpha+lastBeta*rect.minX)*(CGFloat(1.0)-CGFloat(stepCount!)/CGFloat(totalStep))
        bezierPath.addLineToPoint(CGPoint(x: rect.minX, y: minYIntsectNowPart+minYIntsectPastPart))
        
        UIColor(hue: 0.5722, saturation: 1, brightness: 0.86, alpha: 1.0).setStroke()
        bezierPath.lineWidth = 5.0
        bezierPath.stroke()
        stepCount = stepCount! + 1
    }
}
