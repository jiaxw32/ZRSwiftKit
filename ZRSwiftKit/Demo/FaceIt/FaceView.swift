//
//  FaceView.swift
//  ZRSwiftKit
//
//  Created by jiaxw-mac on 2017/9/21.
//  Copyright © 2017年 jiaxw32. All rights reserved.
//

import UIKit

@IBDesignable
class FaceView: UIView {
    
    //1.0 is full smile and -1.0 is full frown
    @IBInspectable
    var mouthCurvature: Double = 0.5 {
        didSet{
            setNeedsDisplay()
        }
    }
    
    @IBInspectable
    var eyesOpen: Bool = true {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable
    var scale: CGFloat = 0.9 {
        didSet{
            setNeedsDisplay()
        }
    }
    
    @IBInspectable
    var lineWidth: CGFloat = 5.0 {
        didSet{
            setNeedsDisplay()
        }
    }
    
    @IBInspectable
    var color = UIColor.blue {
        didSet{
            setNeedsDisplay()
        }
    }
    
    //脸庞中心点坐标
    private var skullCenter: CGPoint {
        return CGPoint(x: bounds.midX, y: bounds.midY)
    }
    
    //脸庞半径
    private var skullRadius: CGFloat {
        return min(bounds.size.width, bounds.size.height) / 2 * scale
    }
    
    //绘制脸庞路径
    private func pathForSkull() -> UIBezierPath {
        let path = UIBezierPath(arcCenter: skullCenter, radius: skullRadius, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: false)
        path.lineWidth = lineWidth
        return path
    }
    
    //脸与眼、嘴比例
    private struct Ratios {
        static let skullRadiusToEyeOffset: CGFloat = 3
        static let skullRadiusToEyeRadius: CGFloat = 10
        static let skullRadiusToMouthWidth: CGFloat = 1
        static let skullRadiusToMouthHeight: CGFloat = 3
        static let skullRadiusToMouthOffset: CGFloat = 3
    }
    
    enum Eye {
        case left
        case right
    }
    
    //左、右眼路径
    private func pathForEye(_ eye: Eye) -> UIBezierPath {
        
        func centerOfEye(_ eye: Eye) -> CGPoint{
            let eyeOffset = skullRadius / Ratios.skullRadiusToEyeOffset
            var eyeCenter = skullCenter
            eyeCenter.y -= eyeOffset
            eyeCenter.x += (eye == .left ? -1 : 1) * eyeOffset
            return eyeCenter
        }
        
        let eyeRadius = skullRadius / Ratios.skullRadiusToEyeRadius
        let eyeCenter = centerOfEye(eye)
        
        
        let path: UIBezierPath
        
        if eyesOpen {
            path = UIBezierPath(arcCenter: eyeCenter, radius: eyeRadius, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
        } else {
            path = UIBezierPath()
            path.move(to: CGPoint(x: eyeCenter.x - eyeRadius, y: eyeCenter.y))
            path.addLine(to: CGPoint(x: eyeCenter.x + eyeRadius, y: eyeCenter.y))
        }
        path.lineWidth = lineWidth
        return path
    }
    
    //嘴路径
    func pathForMouth() -> UIBezierPath {
        let mouthWidth = skullRadius / Ratios.skullRadiusToMouthWidth
        let mouthHeight = skullRadius / Ratios.skullRadiusToMouthHeight
        let mouthOffset = skullRadius / Ratios.skullRadiusToMouthOffset
        
        let moutRect: CGRect = CGRect(x: skullCenter.x - mouthWidth / 2, y: skullCenter.y + mouthOffset, width: mouthWidth, height: mouthHeight)
        
//        let pathRect = UIBezierPath(rect: moutRect)
//        pathRect.lineWidth = lineWidth
//        pathRect.stroke()
        
        //偏移范围为： moutRect * [-1,1]
        let smileOffset = CGFloat(max(-1, min(mouthCurvature, 1))) * moutRect.height
        
        let start = CGPoint(x: moutRect.minX, y: moutRect.midY)
        let end = CGPoint(x: moutRect.maxX, y: moutRect.midY)
        let cp1 = CGPoint(x: start.x + moutRect.width / 3, y: start.y + smileOffset)
        let cp2 = CGPoint(x: end.x - moutRect.width / 3 , y: start.y + smileOffset)
        
        let path = UIBezierPath()
        path.move(to: start)
        path.addCurve(to: end, controlPoint1: cp1, controlPoint2: cp2)
        path.lineWidth = lineWidth
        
        return path
    }
    
    override func draw(_ rect: CGRect) {
        color.set()
        pathForSkull().stroke()
        pathForEye(.left).stroke()
        pathForEye(.right).stroke()
        pathForMouth().stroke()
    }
    
    //缩放
    func changeScale(byReactTo pinRecognizer:UIPinchGestureRecognizer) {
        switch pinRecognizer.state {
        case .changed:
            scale *= pinRecognizer.scale
            pinRecognizer.scale = 1.0
        default:
            break
        }
    }

}
