//
//  LinearGUessCorrelationGameViewController.swift
//  Guess Correlation Plus
//
//  Created by Mingjian Lu on 5/1/16.
//  Copyright © 2016 Capur. All rights reserved.
//
// Thanks https://github.com/alskipp/ASValueTrackingSlider
// Thanks http://stackoverflow.com/questions/26542035/create-uiimage-with-solid-color-in-swift
// Thanks https://github.com/danielgindi/Charts (Give up, too hard to use)

import UIKit
import ASValueTrackingSlider
import SCLAlertView

class LinearGUessCorrelationGameViewController: UIViewController {
    var slider: ASValueTrackingSlider?
    var confirmButton: ZFRippleButton?
    var gameGrid: GridView?
    var scatter: ScatterPlotView?
    var curPoints: [(CGFloat, CGFloat)]?
    var correlation: CGFloat?
    var pNum = 30
    var lifeImage: UIImageView?
    var lifeLabel: UILabel?
    var lifeNum = 3
    var goldImage: UIImageView?
    var goldLabel: UILabel?
    var goldNum = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        initGameMainDisplay()
        initASValueTrackingSlider()
        initButton()
        initBackground()
        initGamaStats()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        showNewPoints()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    func showNewPoints() {
        curPoints = DataKit.generateRandomPointes(pNum, minX: self.view.frame.minX, maxX: self.view.frame.maxX, minY: self.view.frame.minY, maxY: self.slider!.frame.maxY)
        scatter?.currentPoints = self.curPoints!
        scatter?.curIndex = pNum - 1
        scatter?.setNeedsDisplay()
        correlation = DataKit.calculateCorrelation(curPoints!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initGameMainDisplay() {
        let grid = GridView(frame: self.view.frame, ihstepSize: 20.0, iwStepSize: 20.0)
        gameGrid = grid
        self.view.addSubview(grid)
        scatter = ScatterPlotView(frame: self.view.frame)
        self.view.addSubview(scatter!)
    }
    
    func initASValueTrackingSlider() {
        let width = self.view.frame.maxX*3.0/4.0
        let asvts = ASValueTrackingSlider(frame: CGRect(x: self.view.frame.maxX/2.0 - width/2.0, y: self.view.frame.maxY*3.0/4.0, width: width, height: 30))
        slider = asvts
        asvts.maximumValue = 1
        asvts.popUpViewCornerRadius = 12.0
        asvts.setMaxFractionDigitsDisplayed(3)
        asvts.popUpViewColor = UIColor(hue: 0.55, saturation: 0.8, brightness: 0.9, alpha: 0.9)
        asvts.font = UIFont(name: "GillSans-Bold", size: 22)
        asvts.textColor = UIColor(hue: 0.55, saturation: 1.0, brightness: 0.5, alpha: 1.0)
        asvts.setThumbImage(getImageWithColor(UIColor(hue: 0.55, saturation: 0.8, brightness: 0.9, alpha: 1.0), size: CGSize(width: 20, height: 20)), forState: UIControlState.Normal)
        asvts.addTarget(self, action: #selector(self.sliderVal(_:)), forControlEvents: UIControlEvents.ValueChanged)
        self.view.addSubview(asvts)
    }
    
    func getImageWithColor(color: UIColor, size: CGSize) -> UIImage {
        let rect = CGRectMake(0, 0, size.width, size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    func initButton() {
        let x = ZFRippleButton(frame: CGRect(x: self.view.frame.maxX/2.0 - 75, y: self.view.frame.maxY*6.0/7.0, width: 150, height: 40))
        x.setTitle("Let's Go!", forState: UIControlState.Normal)
        x.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 20)
        x.buttonCornerRadius = 7
        x.shadowRippleEnable = true
        x.rippleOverBounds = true
        x.trackTouchLocation = true
        x.rippleColor = UIColor.clearColor()
        x.rippleBackgroundColor = UIColor(hue: 0.5417, saturation: 1, brightness: 1, alpha: 0.5)
        x.backgroundColor = UIColor(hue: 0.5806, saturation: 0.88, brightness: 0.97, alpha: 0.9)
        self.view.addSubview(x)
        confirmButton = x
        x.addTarget(self, action: #selector(self.confirmAnswer(_:)), forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func initGamaStats() {
        lifeImage = UIImageView(image: UIImage(named: "heart_2.gif"))
        lifeImage!.frame =  CGRect(x: (self.confirmButton?.frame.maxX)! + self.view.frame.maxX/20, y: ((self.confirmButton?.frame.maxY)! - (self.confirmButton?.frame.height)!/2), width: 20, height: 20)
        self.view.addSubview(self.lifeImage!)
        
        goldImage = UIImageView(image: UIImage(named: "Spinning_Coin.gif"))
        goldImage!.frame =  CGRect(x: (self.confirmButton?.frame.maxX)! + self.view.frame.maxX/20 - 5, y: ((self.confirmButton?.frame.maxY)!), width: 30, height: 30)
        self.view.addSubview(self.goldImage!)
        
        lifeLabel = UILabel(frame: CGRect(x: (self.confirmButton?.frame.maxX)! + self.view.frame.maxX/20 + 30, y: ((self.confirmButton?.frame.maxY)! - (self.confirmButton?.frame.height)!/2), width: 30, height: 20))
        goldLabel = UILabel(frame: CGRect(x: (self.confirmButton?.frame.maxX)! + self.view.frame.maxX/20 + 30, y: ((self.confirmButton?.frame.maxY)!) + 3, width: 30, height: 20))
        lifeLabel?.backgroundColor = UIColor.clearColor()
        goldLabel?.backgroundColor = UIColor.clearColor()
        lifeLabel?.textColor = UIColor.whiteColor()
        goldLabel?.textColor = UIColor.whiteColor()
        lifeLabel?.adjustsFontSizeToFitWidth = true
        goldLabel?.adjustsFontSizeToFitWidth = true
        lifeLabel?.text = "\(self.lifeNum)"
        goldLabel?.text = "\(self.goldNum)"
        self.view.addSubview(lifeLabel!)
        self.view.addSubview(goldLabel!)
    }
    
    func initBackground() {
        self.view.backgroundColor = UIColor(hue: 0.025, saturation: 0, brightness: 0.89, alpha: 1.0)
    }

    
    func sliderVal(sender: UISlider) {
        // Here is for cheating, add your own code to guess the answer
    }
    
    func confirmAnswer(sender: UIButton) {
        // guess within 0.05 of the true correlation: +1 life and +5 coins
        // guess within 0.10 of the true correlation: +1 coin
        // guess within >0.10 of the true correlation: -1 life
        let cor = Float(correlation!)
        if fabs(cor - (slider?.value)!) <= 0.05 {
            lifeNum += 1
            goldNum += 5
            let popUp = SCLAlertView()
            popUp.showSuccess("Congrats!", subTitle: "Correlation is \(cor)!\nGuess within 0.05 of the true correlation: +1 life and +5 coins", closeButtonTitle: "Continue to win!")
        } else if fabs(cor - (slider?.value)!) <= 0.10 {
            goldNum += 1
            let popUp = SCLAlertView()
            popUp.showInfo("Not Bad!", subTitle: "Correlation is \(cor)!\nGuess within 0.10 of the true correlation: +1 coin", closeButtonTitle: "Be more precise!")
        } else {
            lifeNum -= 1
            let popUp = SCLAlertView()
            if lifeNum == 0 {
                popUp.addButton("Play again") {
                    self.lifeNum = 3
                    self.goldNum = 0
                    self.lifeLabel?.text = "\(self.lifeNum)"
                    self.goldLabel?.text = "\(self.goldNum)"
                }
                popUp.addButton("Exit to main menu T^T") {
                    self.dismissViewControllerAnimated(true, completion: {})
                }
                popUp.showCloseButton = false
                popUp.showError("Meowwww!", subTitle: "Correlation is \(cor)!\nGuess within >0.10 of the true correlation: -1 life\nYou have no more life!", closeButtonTitle: "")
            } else {
                popUp.showWarning("Oooops!", subTitle: "Correlation is \(cor)!\nGuess within >0.10 of the true correlation: -1 life", closeButtonTitle: "Life is learning!")
            }
        }
        lifeLabel?.text = "\(self.lifeNum)"
        goldLabel?.text = "\(self.goldNum)"
        showNewPoints()
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    

}
