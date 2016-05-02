//
//  RandomPointGenerator.swift
//  Guess Correlation Plus
//
//  Created by Mingjian Lu on 4/24/16.
//  Copyright © 2016 Capur. All rights reserved.
//

// Thanks erdekhayser @ http://stackoverflow.com/questions/26029393/random-number-between-two-decimals-in-swift
// Thanks evgenyneu @ https://github.com/evgenyneu/SigmaSwiftStatistics

import Foundation
import UIKit
import SigmaSwiftStatistics

class DataKit {
    
    static func generateRandomPointes(count: Int, minX: CGFloat, maxX: CGFloat, minY: CGFloat, maxY: CGFloat) -> [(CGFloat, CGFloat)] {
        var ret: [(CGFloat, CGFloat)] = []
        for _ in 1...count {
            let randomX = randomBetweenNumbers(minX, secondNum: maxX)
            let randomY = randomBetweenNumbers(minY, secondNum: maxY)
            ret.append((randomX, randomY))
        }
        return ret
    }
    
    static func randomBetweenNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
    
    static func calculateCorrelation(withPoints: [(CGFloat, CGFloat)]) -> CGFloat {
        let x = withPoints.map({Double(Float($0.0))})
        let y = withPoints.map({Double(Float($0.1))})
        return CGFloat(Sigma.pearson(x: x, y: y)!)
    }
    
    static func findAlphaAndBeta(withPoints: [(CGFloat, CGFloat)]) -> (CGFloat, CGFloat) {
        let x = withPoints.map({Double(Float($0.0))})
        let y = withPoints.map({Double(Float($0.1))})
        let cov = Sigma.covariancePopulation(x: x, y: y)
        let varX = Sigma.variancePopulation(x)
        let beta = cov!/varX!
        let xAvg = Sigma.average(x)
        let yAvg = Sigma.average(y)
        let alpha = yAvg! - beta * xAvg!
        return (CGFloat(alpha), CGFloat(beta))
    }
}