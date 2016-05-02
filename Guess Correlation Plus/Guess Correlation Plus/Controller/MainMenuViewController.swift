//
//  MainMenuViewController.swift
//  Guess Correlation Plus
//
//  Created by Mingjian Lu on 4/24/16.
//  Copyright © 2016 Capur. All rights reserved.
//

// Thanks for William Falcon @ https://medium.com/swift-programming/animating-a-smiley-face-across-the-screen-in-swift-dc808c7ca20c#.pbvvpixnk
// Thanks for https://github.com/erkekin/EERegression (Not used here)
// Thanks for https://github.com/vikmeup/SCLAlertView-Swift

import UIKit
import SCLAlertView

class MainMenuViewController: UIViewController {
    
    var startButton: MainMenuStartButton?
    var headTitle: UILabel?
    var backgroundDynamics: MainMenuBackgroundView?
    var singlePlayerButton: ZFRippleButton?
    var multiPlayerButton: ZFRippleButton?
    var pageStatus = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        addButtonsAndTitle()
        addGesture()
        addTarget()
        pageStatus = 1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func addTarget() {
        startButton!.addTarget(self, action: #selector(MainMenuViewController.startNewGame(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        singlePlayerButton!.addTarget(self, action: #selector(MainMenuViewController.startSingleGame(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        multiPlayerButton!.addTarget(self, action: #selector(MainMenuViewController.startMultiGame(_:)), forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func addGesture() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeDetected(_:)))
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeDetected(_:)))
        swipeDown.direction = UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(swipeDown)
    }
    
    func swipeDetected(sender:UISwipeGestureRecognizer) {
        if (sender.direction == .Left) {
            if pageStatus == 2 {
                
            } else if pageStatus == 1 {
                moveViewToLeftDisappear(startButton!)
                moveViewToLeftDisappear(headTitle!)
                moveViewToCenterReappear(singlePlayerButton!)
                moveViewToCenterReappear(multiPlayerButton!)
                pageStatus = 2
            } else if pageStatus == 0 {
                moveViewToCenterReappear(startButton!)
                moveViewToCenterReappear(headTitle!)
                pageStatus = 1
            }
        }
        
        if (sender.direction == .Right) {
            if pageStatus == 0 {
                
            } else if pageStatus == 1 {
                moveViewToRightDisappear(startButton!)
                moveViewToRightDisappear(headTitle!)
                pageStatus = 0
            } else if pageStatus == 2 {
                moveViewToCenterReappear(startButton!)
                moveViewToCenterReappear(headTitle!)
                moveViewToRightDisappear(singlePlayerButton!)
                moveViewToRightDisappear(multiPlayerButton!)
                pageStatus = 1
            }
        }
    }
    
    func moveView(view:UIView, toPoint destination:CGPoint, completion:(()->())?) {
     //Always animate on main thread
     dispatch_async(dispatch_get_main_queue(), {
       //Use UIView animation API
       UIView.animateWithDuration(1.0, delay: 0.0, usingSpringWithDamping:
        0.6, initialSpringVelocity: 0.3, options:
        UIViewAnimationOptions.AllowAnimatedContent, animations: { () ->
        Void in
               //do actual move
               view.center = destination
        }, completion: { (complete) -> Void in
               //when animation completes, activate block if not nil
               if complete {
                  if let c = completion {
                     c()
                  }
               }
        })
     })
    }
    
    func moveViewToLeftDisappear(view:UIView) {
        moveView(view, toPoint: CGPointMake(0.0 - view.frame.width/2, view.frame.midY), completion: nil)
    }
    
    func moveViewToRightDisappear(view:UIView) {
        moveView(view, toPoint: CGPointMake(self.view.frame.maxX + view.frame.width/2, view.frame.midY), completion: nil)
    }
    
    func moveViewToCenterReappear(view:UIView) {
        moveView(view, toPoint: CGPointMake(self.view.frame.midX, view.frame.midY), completion: nil)
    }

    func addButtonsAndTitle() {
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        
        // Background
        let backGround = MainMenuBackgroundView(frame: screenSize)
        self.view.addSubview(backGround)
        backgroundDynamics = backGround
        
        // StartGameButton
        let buttonSize = CGFloat(85.0)
        let button = MainMenuStartButton(frame: CGRect(x: (screenSize.width-buttonSize)/2.0, y: (screenSize.height-buttonSize)*1.7/3.0, width: buttonSize, height: buttonSize))
        button.buttonCornerRadius = 85.0/2.0
        button.shadowRippleEnable = true
        button.rippleOverBounds = false
        button.trackTouchLocation = true
        button.rippleColor = UIColor(hue: 0.5889, saturation: 0.88, brightness: 1, alpha: 0.6)
        button.rippleBackgroundColor = UIColor.clearColor()
        self.view.addSubview(button)
        startButton = button
        
        // HeadTitle
        let label: UILabel = UILabel(frame: CGRect(x: screenSize.width*0.1, y: screenSize.height/3.0, width: screenSize.width*0.8, height: 30.0))
        label.font = UIFont(name: "Helvetica Neue", size: 30)
        label.backgroundColor = UIColor.clearColor()
        label.textColor = UIColor.whiteColor()
        label.textAlignment = NSTextAlignment.Center
        label.text = "Guess Correlation Plus"
        self.view.addSubview(label)
        headTitle = label
        
        // Hidden single player and multiplayer button
        var x = ZFRippleButton(frame: CGRect(x: screenSize.width*0.1, y: screenSize.height/3.0, width: screenSize.width*0.6, height: 60.0))
        x.setTitle("Solo Game", forState: UIControlState.Normal)
        x.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 25)
        x.buttonCornerRadius = 5
        x.shadowRippleEnable = true
        x.rippleOverBounds = false
        x.trackTouchLocation = true
        x.rippleColor = UIColor(hue: 0.6139, saturation: 0.88, brightness: 0.87, alpha: 1.0)
        x.rippleBackgroundColor = UIColor(hue: 0.5806, saturation: 0.88, brightness: 0.97, alpha: 1.0)
        x.backgroundColor = UIColor(hue: 0.5806, saturation: 0.88, brightness: 0.97, alpha: 0.9)
        moveViewToRightDisappear(x)
        self.view.addSubview(x)
        singlePlayerButton = x
        
        x = ZFRippleButton(frame: CGRect(x: screenSize.width*0.1, y: screenSize.height/3.0 + 120, width: screenSize.width*0.6, height: 60.0))
        x.setTitle("Multi-Player Game", forState: UIControlState.Normal)
        x.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 25)
        x.buttonCornerRadius = 5
        x.shadowRippleEnable = true
        x.rippleOverBounds = false
        x.trackTouchLocation = true
        x.rippleColor = UIColor(hue: 0.6139, saturation: 0.88, brightness: 0.87, alpha: 1.0)
        x.rippleBackgroundColor = UIColor(hue: 0.5806, saturation: 0.88, brightness: 0.97, alpha: 1.0)
        x.backgroundColor = UIColor(hue: 0.5806, saturation: 0.88, brightness: 0.97, alpha: 0.9)
        moveViewToRightDisappear(x)
        self.view.addSubview(x)
        multiPlayerButton = x
    }
    
    func startNewGame(sender:UIButton) {
        moveViewToLeftDisappear(startButton!)
        moveViewToLeftDisappear(headTitle!)
        moveViewToCenterReappear(singlePlayerButton!)
        moveViewToCenterReappear(multiPlayerButton!)
        pageStatus = 2
    }
    
    func startSingleGame(sender: UIButton) {
        performSegueWithIdentifier("SingleGameSegue", sender: nil)
    }

    func startMultiGame(sender: UIButton) {
        let nameReqView = SCLAlertView()
        let txt = nameReqView.addTextField("Your Name")
        nameReqView.addButton("Confirm") {
            print("Text value: \(txt.text)")
        }
        nameReqView.showEdit("Online Battle Name", subTitle: "Plz give me a name between 1 to 10 chars without weird encodings, sorry server is still very naive XD", closeButtonTitle: "Close")
    }
}
