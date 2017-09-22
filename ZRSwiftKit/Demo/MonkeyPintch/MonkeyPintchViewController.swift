//
//  MonkeyPintchViewController.swift
//  ZRSwiftKit
//
//  Created by jiaxw-mac on 2017/9/22.
//  Copyright © 2017年 jiaxw32. All rights reserved.
//

import UIKit
import AVFoundation

class MonkeyPintchViewController: UIViewController {
    
    var chompPlayer: AVAudioPlayer?
    var hehePlayer: AVAudioPlayer?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let filterViews = view.subviews.filter{$0 is UIImageView}
        for imageView in filterViews {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:)))
            tapGesture.delegate = self
            imageView.addGestureRecognizer(tapGesture)
            
            let tickleGesture = TickleGestureRecognizer(target: self, action: #selector(handleTickle(recognizer:)))
            tickleGesture.delegate = self
            imageView.addGestureRecognizer(tickleGesture)
        }
        
        
        chompPlayer = loadSound(filename: "chomp")
        hehePlayer = loadSound(filename: "hehehe1")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadSound(filename: String) -> AVAudioPlayer? {
//        let filePath = Bundle.main.path(forResource: filename, ofType: "caf")
//        print(filePath ?? "not find")
        
        let url = Bundle.main.url(forResource: filename, withExtension: "caf")
        do {
            if let audioPath = url {
                let player = try AVAudioPlayer(contentsOf: audioPath)
                player.prepareToPlay()
                return player
            }
        } catch {
            print("error loading \(String(describing: url)):\(error.localizedDescription)")
        }
        return nil
    }
    
    //MARK: gesture handler
    
    func handleTap(recognizer: UITapGestureRecognizer) {
        chompPlayer?.play()
    }
    
    func handleTickle(recognizer: TickleGestureRecognizer) {
        hehePlayer?.play()
    }
    
    
    @IBAction func handlePan(recognizer: UIPanGestureRecognizer) {
        
        let translation = recognizer.translation(in: self.view)
        if let view = recognizer.view {
            view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
        }
        recognizer.setTranslation(CGPoint.zero, in: self.view)
        
        if recognizer.state == .ended {
            let velocity = recognizer.velocity(in: self.view)
            let magnitude = sqrt(velocity.x * velocity.x + velocity.y * velocity.y)
            let slideMultiplier = magnitude / 200
//            print("velocity:x=\(velocity.x),y=\(velocity.y),magnitude: \(magnitude), slideMultiplier: \(slideMultiplier)")
            
            let slideFactor = 0.1 * slideMultiplier
            var finalPoint = CGPoint(x: recognizer.view!.center.x + slideFactor * velocity.x, y: recognizer.view!.center.y + slideFactor * velocity.y)
            finalPoint.x = min(max(0, finalPoint.x), self.view.bounds.size.width)
            finalPoint.y = min(max(0, finalPoint.y), self.view.bounds.size.height)
            
            UIView.animate(withDuration: Double(slideFactor * 2), delay: 0, options: .curveEaseOut, animations: { 
                recognizer.view?.center = finalPoint
            }, completion: nil)
        }
    }
    
    @IBAction func handlePinch(recognizer: UIPinchGestureRecognizer) {
        if let view = recognizer.view {
            view.transform = view.transform.scaledBy(x: recognizer.scale, y: recognizer.scale)
            recognizer.scale = 1
        }
    }
    
    @IBAction func handleRotate(recognizer: UIRotationGestureRecognizer) {
        if let view = recognizer.view {
            view.transform = view.transform.rotated(by: recognizer.rotation)
        }
    }
}

//MARK: - UIGestureRecognizerDelegate

extension MonkeyPintchViewController:UIGestureRecognizerDelegate{
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
