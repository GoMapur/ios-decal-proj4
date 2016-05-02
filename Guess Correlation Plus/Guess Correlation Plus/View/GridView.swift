//
//  GridView.swift
//  Guess Correlation Plus
//
//  Created by Mingjian Lu on 4/25/16.
//  Copyright © 2016 Capur. All rights reserved.
//

import UIKit

class GridView: UIView {
    
    var hStepSize: CGFloat = 10.0
    var wStepSize: CGFloat = 10.0
    
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
    
    init(frame: CGRect, ihstepSize: CGFloat, iwStepSize: CGFloat) {
        super.init(frame: frame)
        setup()
        hStepSize = ihstepSize
        wStepSize = iwStepSize
    }
    
    func setup() {
        self.backgroundColor = UIColor.blackColor()
        self.tintColor = UIColor.clearColor()
        hStepSize = 10.0
        wStepSize = 10.0
    }

    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        drawcoordinates(rect)
    }
 
    
    func drawcoordinates(rect: CGRect) {
        var cur: CGFloat = 0.0
        while cur <= rect.height {
            let bezierPath = UIBezierPath()
            bezierPath.moveToPoint(CGPointMake(0.0, cur))
            bezierPath.addLineToPoint(CGPointMake(rect.width, cur))
            UIColor(hue: 0.6528, saturation: 0.15, brightness: 0.58, alpha: 1.0).setStroke()
            bezierPath.stroke()
            cur += hStepSize
        }
        cur = 0.0
        while cur <= rect.width {
            let bezierPath = UIBezierPath()
            bezierPath.moveToPoint(CGPointMake(cur, 0))
            bezierPath.addLineToPoint(CGPointMake(cur, rect.height))
            UIColor(hue: 0.6528, saturation: 0.15, brightness: 0.58, alpha: 1.0).setStroke()
            bezierPath.stroke()
            cur += wStepSize
        }
    }

}
