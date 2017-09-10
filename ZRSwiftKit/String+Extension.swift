//
//  String+Extension.swift
//  ZRSwiftKit
//
//  Created by jiaxw-mac on 2017/9/10.
//  Copyright © 2017年 jiaxw32. All rights reserved.
//

import Foundation

extension String{
    
    static func uuid() -> String {
        let uuid = UUID().uuidString
        return uuid.replacingOccurrences(of: "-", with: "").lowercased()
    }
    
    func lastIndex(of aString: String) -> String.Index? {
        let range = self.range(of: aString, options: .backwards)
        return range?.lowerBound
    }
    
    func append(aString: String, with seperator: String) -> String {
        if self.characters.count == 0 {
            return aString
        } else {
            if aString.characters.count > 0 {
                return self + seperator + aString
            } else {
                return self
            }
        }
    }
}
