//
//  MainMenuBackgroundView.swift
//  Guess Correlation Plus
//
//  Created by Mingjian Lu on 4/24/16.
//  Copyright © 2016 Capur. All rights reserved.
//

// Thanks KeithErmel @ https://gist.github.com/KeithErmel/646852d0ffc9b59c7978

import UIKit

class MainMenuBackgroundView: UIView {
    
    var timer: NSTimer?
    var randomPoints: [(CGFloat, CGFloat)]?
    var pNum = 30
    
    var grid: GridView?
    var scatter: ScatterPlotView?
    var line: LineAnimationView?
    
    var animationDuration = 0.1
    var drawLinePauseDuration = 0.0005

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    init () {
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
        grid = GridView(frame: self.frame)
        scatter = ScatterPlotView(frame: self.frame)
        line = LineAnimationView(frame: self.frame)
        self.addSubview(grid!)
        self.addSubview(scatter!)
        self.addSubview(line!)
        addTimer()
    }
    
    func addTimer() {
        if timer != nil {
            timer?.invalidate()
        }
        timer = NSTimer(timeInterval: animationDuration, target: self, selector: #selector(self.plotGraph), userInfo: nil, repeats: true)
        NSRunLoop.currentRunLoop().addTimer(timer!, forMode: NSRunLoopCommonModes)
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        
    }*/
    
    func plotGraph() {
        if scatter?.curIndex == pNum - 1 || scatter?.currentPoints == nil {
            addRandomPoints()
            scatter?.currentPoints = self.randomPoints
            scatter?.curIndex = 0
            line?.currentPoints = self.randomPoints
            line?.curIndex = 0
            line?.finished = true
        } else {
            line?.finished = false
        }
        scatter?.setNeedsDisplay()
        line?.curIndex = (scatter?.curIndex)!
        line?.stepCount = 0
        timer?.invalidate()
        timer = NSTimer(timeInterval: drawLinePauseDuration, target: self, selector: #selector(self.plotLine), userInfo: nil, repeats: true)
        NSRunLoop.currentRunLoop().addTimer(timer!, forMode: NSRunLoopCommonModes)
    }
    
    func plotLine() {
        if line?.finished != true {
            line?.setNeedsDisplay()
        } else {
            timer?.invalidate()
            timer = NSTimer(timeInterval: animationDuration, target: self, selector: #selector(self.plotGraph), userInfo: nil, repeats: true)
            NSRunLoop.currentRunLoop().addTimer(timer!, forMode: NSRunLoopCommonModes)
        }
    }
    
    func addRandomPoints() {
        randomPoints = DataKit.generateRandomPointes(pNum, minX: self.frame.minX, maxX: self.frame.maxX, minY: self.frame.minY, maxY: self.frame.maxY)
    }

}
