//
//  PlaceholderTextViewController.swift
//  ZRSwiftKit
//
//  Created by jiaxw-mac on 2017/9/15.
//  Copyright © 2017年 jiaxw32. All rights reserved.
//

import UIKit

class PlaceholderTextViewController: UIViewController {

    @IBOutlet weak var topTextView: ZRPlaceholderTextView!
    @IBOutlet weak var midTextView: ZRPlaceholderTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        topTextView.placeholder = "normal placeholder"
        
        midTextView.placeholder = "placeholder with text container inset"
        let inset = UIEdgeInsetsMake(12, 16, 12, 16)
        midTextView.textContainerInset = inset
        midTextView.maxCount = 10
        
        
        let placeholder = "attribute placeholder"
        let attributePlaceholder = NSAttributedString(string: placeholder, attributes: [NSForegroundColorAttributeName: UIColor.black])
        
        let width = UIScreen.main.bounds.size.width - 20 * 2
        let bottomTextView = ZRPlaceholderTextView(frame: CGRect(x: 20, y: 352, width: width, height: 120))
        
        bottomTextView.attributedPlaceholder = attributePlaceholder
        bottomTextView.backgroundColor = topTextView.backgroundColor
        
        self.view.addSubview(bottomTextView)
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
