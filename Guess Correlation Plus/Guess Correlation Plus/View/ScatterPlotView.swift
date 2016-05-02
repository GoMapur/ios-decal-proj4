//
//  ScatterPlotView.swift
//  Guess Correlation Plus
//
//  Created by Mingjian Lu on 4/25/16.
//  Copyright © 2016 Capur. All rights reserved.
//

import UIKit

class ScatterPlotView: UIView {
    
    var currentPoints: [(CGFloat, CGFloat)]? = nil
    var curIndex = 0

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
        curIndex = 0
    }
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        if currentPoints != nil {
            for i in 0...curIndex {
                let path = UIBezierPath(arcCenter: CGPointMake(currentPoints![i].0, currentPoints![i].1), radius: 7.0, startAngle: CGFloat(0), endAngle:CGFloat(M_PI * 2), clockwise: true)
                UIColor.orangeColor().setFill()
                path.fill()
            }
        }
        curIndex += 1
    }

}
