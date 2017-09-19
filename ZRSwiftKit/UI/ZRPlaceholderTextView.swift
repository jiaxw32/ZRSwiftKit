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
            if self.text != oldValue {
                setNeedsDisplay()
            }
        }
    }
    
    override var attributedText: NSAttributedString! {
        didSet {
            if self.attributedText != oldValue {
                setNeedsDisplay()
            }
        }
    }
    
    override var font: UIFont? {
        didSet{
            setNeedsDisplay()
        }
    }
    
    override var textContainerInset: UIEdgeInsets {
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
    
    var maxCount: UInt? {
        didSet{
            setNeedsDisplay()
        }
    }
    
    var maxCountTextAttribute: [String:Any]? {
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
        
        if maxCount != nil {
            
            if maxCountTextAttribute == nil {
                var attributes = [String: Any]()
                attributes[NSFontAttributeName] = font
                attributes[NSForegroundColorAttributeName] = UIColor.init(white: 0.702, alpha: 1.0)
                let paragraph = NSMutableParagraphStyle()
                paragraph.alignment = .right
                attributes[NSParagraphStyleAttributeName] = paragraph
                maxCountTextAttribute = attributes
            }
            
            let maxCountAttributeString = NSAttributedString(string: "\(text.characters.count)/\(maxCount!)", attributes: maxCountTextAttribute)
            
            maxCountAttributeString.draw(in: self.maxCountRectForBounds(bounds: rect))
        }
    }
    
    //MARK: - custom method
    
    private func placeholderRectForBounds(bounds: CGRect) -> CGRect {
        var rect = UIEdgeInsetsInsetRect(bounds, contentInset)
        
        if self.responds(to: #selector(getter: textContainer)) {
            rect = UIEdgeInsetsInsetRect(rect, self.textContainerInset)
            let padding = textContainer.lineFragmentPadding
            rect.origin.x += padding
            rect.size.width -= 2 * padding
        } else {
            if contentInset.left == 0 {
                rect.origin.x += 6.0
            }
        }
        return rect
    }
    
    func maxCountRectForBounds(bounds: CGRect) -> CGRect {
        
        
        let padding: CGFloat = 16
        
        let font = maxCountTextAttribute![NSFontAttributeName] as? UIFont
        let fontSize = font?.pointSize ?? 16
        let y = bounds.size.height - padding - fontSize + contentOffset.y

        let width = bounds.size.width - padding * 2
        return CGRect(x: padding, y: y, width: width, height: fontSize)
    }
    
    func initialize() -> Void {
        NotificationCenter.default.addObserver(self, selector: #selector(textChanged(notification:)), name: NSNotification.Name.UITextViewTextDidChange, object: nil)
    }
    
    func textChanged(notification: Notification) -> Void {
        
        
        if maxCount != nil && UInt(text.characters.count) > maxCount! {
            let startIndex = text.startIndex
            let lastIndex = text.index(text.startIndex, offsetBy: Int(maxCount!))
            text = text[startIndex..<lastIndex]
        }
        setNeedsDisplay()
    }
    
}


