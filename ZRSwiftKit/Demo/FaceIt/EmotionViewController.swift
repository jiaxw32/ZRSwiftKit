//
//  EmotionViewController.swift
//  ZRSwiftKit
//
//  Created by jiaxw-mac on 2017/9/26.
//  Copyright © 2017年 jiaxw32. All rights reserved.
//

import UIKit

class EmotionViewController: UIViewController {
    
    let emotionMap: [String: FacialExpresison] = [
        "sad" : FacialExpresison(eyes: .closed, mouth: .frown),
        "worried" : FacialExpresison(eyes: .open, mouth: .smirk),
        "happy" : FacialExpresison(eyes: .open, mouth: .smile)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var destViewController = segue.destination
        if let navigationViewController = destViewController as? UINavigationController {
            destViewController = navigationViewController.visibleViewController ?? destViewController
        }
        
        if let emotionViewController = destViewController as? FaceItViewController,
            let identifier = segue.identifier
        {
            if let faceExpression = emotionMap[identifier] {
                emotionViewController.faceExpression = faceExpression
            }
            emotionViewController.navigationItem.title = identifier
        }
    }
    

    @IBAction func actionCancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}
