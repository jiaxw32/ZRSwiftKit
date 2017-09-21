//
//  FaceItViewController.swift
//  ZRSwiftKit
//
//  Created by jiaxw-mac on 2017/9/21.
//  Copyright © 2017年 jiaxw32. All rights reserved.
//

import UIKit

class FaceItViewController: UIViewController {

    // MARK: - Property
    
    @IBOutlet weak var faceView: FaceView!{
        didSet{
            print("didSet faceView")
            
            //捏合
            let pinthcHandler = #selector(FaceView.changeScale(byReactTo:))
            let pintchGesture = UIPinchGestureRecognizer(target: faceView, action: pinthcHandler)
            faceView.addGestureRecognizer(pintchGesture)
            
            //点击
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(FaceItViewController.toggleEyes(byReactingTo:)))
            tapGesture.numberOfTapsRequired = 1
            faceView.addGestureRecognizer(tapGesture)
            
            //轻扫
            let swipUpGesture = UISwipeGestureRecognizer(target: self, action: #selector(increaseHappiness))
            swipUpGesture.direction = .up
            faceView.addGestureRecognizer(swipUpGesture)
            
            let swipDownGesture = UISwipeGestureRecognizer(target: self, action: #selector(decreaseHappiness))
            swipDownGesture.direction = .down
            faceView.addGestureRecognizer(swipDownGesture)
            
            
            updateUI()
        }
    }
    
    var faceExpression = FacialExpresison(eyes: .closed, mouth: .smile){
        didSet{
            print("didSet faceExpression")
            updateUI()
        }
    }
    
    let mouthCurvatures = [
        FacialExpresison.Mouth.frown: -1.0,
        FacialExpresison.Mouth.grin: 0.5,
        FacialExpresison.Mouth.smile: 1.0,
        FacialExpresison.Mouth.neutral: 0.0,
        FacialExpresison.Mouth.smirk: -0.5
    ]
    
    // MARK: - UI
    
    func updateUI() {
        switch faceExpression.eyes {
        case .open:
            faceView?.eyesOpen = true
        case .closed:
            faceView?.eyesOpen = false
        default:
            faceView?.eyesOpen = false
        }
        faceView?.mouthCurvature = mouthCurvatures[faceExpression.mouth] ?? 0.0
    }
    
    // MARK: - Gesture Handler
    
    func toggleEyes(byReactingTo tapRecognizer: UITapGestureRecognizer) {
        switch tapRecognizer.state {
        case .ended:
            let eyes: FacialExpresison.Eyes = (faceExpression.eyes == .open) ? .closed : .open
            faceExpression = FacialExpresison(eyes: eyes, mouth: faceExpression.mouth)
        default:
            break
        }
    }
    
    func increaseHappiness() {
        faceExpression = faceExpression.happier
    }
    
    func decreaseHappiness() {
        faceExpression = faceExpression.sadder
    }

}
