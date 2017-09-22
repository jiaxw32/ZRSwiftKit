//
//  TickleGestureRecognizer.swift
//  ZRSwiftKit
//
//  Created by jiaxw-mac on 2017/9/22.
//  Copyright © 2017年 jiaxw32. All rights reserved.
//

import UIKit

class TickleGestureRecognizer: UIGestureRecognizer {
    
    let requiredTickles = 2
    let distanceForTickleGesture: CGFloat = 10.0
    
    enum Direction: Int {
        case DirectionUnknow = 0
        case DirectionLeft
        case DirectionRight
    }
    
    var tickleCount: Int = 0
    var curTickleStart = CGPoint.zero
    var lastDirection = Direction.DirectionUnknow
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        if let touch = touches.first {
            curTickleStart = touch.location(in: self.view)
        }
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        if let touch = touches.first {
            let ticklePoint = touch.location(in: self.view)
            
            let moveAmt = ticklePoint.x - curTickleStart.x
            print("moveAmt:\(moveAmt)")
            var curDirection = Direction.DirectionUnknow
            if moveAmt >= 0 {
                curDirection = .DirectionRight
            } else {
                curDirection = .DirectionLeft
            }
            
            if abs(moveAmt) < distanceForTickleGesture {
                return
            }
            
            if lastDirection == .DirectionUnknow || (lastDirection == .DirectionLeft && curDirection == .DirectionRight) || (lastDirection == .DirectionRight && curDirection == .DirectionLeft) {
                self.tickleCount += 1
                self.curTickleStart = ticklePoint
                self.lastDirection = curDirection
                print("current direction:\(curDirection),tickle count:\(tickleCount)")
                if state == .possible && tickleCount > requiredTickles {
                    state = .ended
                }
            }
        }
    }
    
    override func reset() {
        self.tickleCount = 0
        self.curTickleStart = CGPoint.zero
        self.lastDirection = .DirectionUnknow
        if state == .possible {
            state = .failed
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        reset()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
        reset()
    }
}
