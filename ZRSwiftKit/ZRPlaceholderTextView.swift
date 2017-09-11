//
//  ZRPlaceholderTextView.swift
//  ZRSwiftKit
//
//  Created by jiaxw-mac on 2017/9/10.
//  Copyright © 2017年 jiaxw32. All rights reserved.
//

import UIKit

class ZRPlaceholderTextView:  UITextView{
    
    // MARK: - init
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        initialize()
    }
    
    // MARK: - deinit
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.Name.UITextViewTextDidChange, object: nil)
    }
    
    //MARK: - override attributes
    
    override var text: String! {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override var attributedText: NSAttributedString! {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override var font: UIFont? {
        didSet{
            setNeedsDisplay()
        }
    }
    
    override var contentInset: UIEdgeInsets {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override var textAlignment: NSTextAlignment {
        didSet {
            setNeedsDisplay()
        }
    }
    
    //MARK: - custom attribute
    
    var placeholder: String? {
        get {
            return attributedPlaceholder?.string
        }
        set {
            guard let newPlaceholder = newValue else { return }
            
            guard newPlaceholder != attributedPlaceholder?.string else {
                return
            }
            var attributes = [String: Any]()
            
            if isFirstResponder {
                attributes = typingAttributes
            } else {
                attributes[NSFontAttributeName] = font
                attributes[NSForegroundColorAttributeName] = UIColor.init(white: 0.702, alpha: 1.0)
                
                if textAlignment != NSTextAlignment.left {
                    let paragraph = NSMutableParagraphStyle()
                    paragraph.alignment = textAlignment
                    attributes[NSParagraphStyleAttributeName] = paragraph
                }
            }
            self.attributedPlaceholder = NSAttributedString(string: newPlaceholder, attributes: attributes)
        }
    }
    
    var attributedPlaceholder: NSAttributedString? {
        didSet{
            setNeedsDisplay()
        }
    }

    //MARK: - override method
    
    override func insertText(_ text: String) {
        super.insertText(text)
        setNeedsDisplay()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if text.characters.count == 0 && attributedPlaceholder != nil {
            setNeedsDisplay()
        }
    }
    
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        if text.characters.count == 0 && attributedPlaceholder != nil {
            let placeholderRect = placeholderRectForBounds(bounds: rect)
            attributedPlaceholder!.draw(in: placeholderRect)
        }
    }
    
    //MARK: - custom method
    
    func placeholderRectForBounds(bounds: CGRect) -> CGRect {
        var rect = UIEdgeInsetsInsetRect(bounds, contentInset)
        if contentInset.left == 0 {
            rect.origin.x += 8
        }
        rect.origin.y += 8
        return rect
        
//        if responds(to: #selector(getter: ZRPlaceholderTextView.textContainer)) {
//            rect = UIEdgeInsetsInsetRect(rect, textContainerInset)
//            let padding = textContainer.lineFragmentPadding
//            rect.origin.x += padding
//            rect.size.width -= padding * 2.0
//        } else {
//            if contentInset.left == 0 {
//                rect.origin.x += 8
//            }
//            rect.origin.y += 8
//        }
//        
//        return rect
    }
    
    func initialize() -> Void {
        NotificationCenter.default.addObserver(self, selector: #selector(textChanged(notification:)), name: NSNotification.Name.UITextViewTextDidChange, object: nil)
    }
    
    func textChanged(notification: Notification) -> Void {
        setNeedsDisplay()
    }
    
}


