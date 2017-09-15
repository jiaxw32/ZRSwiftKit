//
//  ViewController.swift
//  ZRSwiftKit
//
//  Created by jiaxw-mac on 2017/9/7.
//  Copyright © 2017年 jiaxw32. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var originalTextview: UITextView!
    @IBOutlet weak var textview: ZRPlaceholderTextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        textview.placeholder = "请输入备注信息(最多200字)"
        
        var inset = UIEdgeInsetsMake(12, 16, 12, 16)
//        inset = UIEdgeInsetsMake(0, 0, 0, 0)
        
        textview.textContainerInset = inset
        originalTextview.textContainerInset = inset
        
//        let tv = ZRPlaceholderTextView(frame: CGRect(x: 20, y: 60, width: 300, height: 100))
//        tv.placeholder = "请输入备注信息(最多200字)"
//        tv.backgroundColor = UIColor.blue
//        self.view .addSubview(tv)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        
    }


}

