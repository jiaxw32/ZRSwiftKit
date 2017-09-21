//
//  FacalExpression.swift
//  ZRSwiftKit
//
//  Created by jiaxw-mac on 2017/9/21.
//  Copyright © 2017年 jiaxw32. All rights reserved.
//

import Foundation

struct FacialExpresison {
    
    enum Eyes: Int {
        case open
        case closed
        case squinting  //迷眼
    }
    
    enum Mouth: Int {
        case frown  //皱眉
        case smirk  //傻笑
        case neutral    //中立的，中性的
        case grin   //露齿笑
        case smile  //微笑
        
        var sadder: Mouth {
            return Mouth(rawValue: rawValue - 1) ?? .frown
        }
        
        var happier: Mouth {
            return Mouth(rawValue: rawValue + 1) ?? .smile
        }
        
    }
    
    var sadder: FacialExpresison {
        return FacialExpresison(eyes: self.eyes, mouth: self.mouth.sadder)
    }
    
    var happier: FacialExpresison {
        return FacialExpresison(eyes: self.eyes, mouth: self.mouth.happier)
    }
    
    let eyes: Eyes
    let mouth: Mouth
    
    
}
