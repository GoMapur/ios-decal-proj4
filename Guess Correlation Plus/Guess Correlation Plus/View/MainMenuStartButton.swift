//
//  MainMenuStartButtonView.swift
//  Guess Correlation Plus
//
//  Created by Mingjian Lu on 4/24/16.
//  Copyright © 2016 Capur. All rights reserved.
//
// Thanks for https://www.raywenderlich.com/90690/modern-core-graphics-with-swift-part-1

import UIKit

class MainMenuStartButton: ZFRippleButton {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    init() {
        super.init(frame: CGRectZero)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    func setup() {
        self.layer.cornerRadius = frame.height/2;
        self.layer.borderColor = UIColor.clearColor().CGColor
        self.layer.borderWidth = 0
        self.backgroundColor = UIColor.clearColor()
        self.tintColor = UIColor.clearColor()
    }

    //Only override drawRect: if you perform custom drawing.
    //An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        for i in 0...10 {
            let precision = CGFloat(10 - i)
            let path = UIBezierPath(arcCenter: CGPoint(x: rect.midX,y: rect.midY), radius: CGFloat(rect.height/2*(precision+1)/11), startAngle: CGFloat(0), endAngle:CGFloat(M_PI * 2), clockwise: true)
            UIColor(hue: 0.5583, saturation: 1, brightness: (0.8 + 0.02 * precision), alpha: 1.0).setFill()
            path.fill()
        }
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(1.1/3.0*rect.width, rect.height*2.2/3.0))
        bezierPath.addLineToPoint(CGPointMake(1.1/3.0*rect.width, rect.height*0.8/3.0))
        bezierPath.addLineToPoint(CGPointMake(2.3/3.0*rect.width, rect.midY))
        bezierPath.closePath()
        UIColor.whiteColor().setFill()
        bezierPath.fill()

    }

}
