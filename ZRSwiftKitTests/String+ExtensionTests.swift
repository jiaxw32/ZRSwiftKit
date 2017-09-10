//
//  String+ExtensionTests.swift
//  ZRSwiftKit
//
//  Created by jiaxw-mac on 2017/9/10.
//  Copyright © 2017年 jiaxw32. All rights reserved.
//

import XCTest
@testable import ZRSwiftKit

class String_ExtensionTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testUUID() {
        let uuid = String.uuid()
        print("the result is \(uuid)")
        XCTAssertNotNil(uuid,"the result shouldn't be nil")
        XCTAssertTrue(uuid.characters.count == 32, "the length of result should be 32")
    }
    
    func testLastIndex() -> Void {
        let str = "/usr/root/desktop"
        let idx = str.lastIndex(of: "/")
        XCTAssertNotNil(idx,"the index shouldn't be nil")
        
        let afterIndex = str.index(after: idx!)
        let subString = str.substring(from: afterIndex)
        
        XCTAssertLessThanOrEqual(subString, "desktop", "subString should be 'desktop'")
    }
    
    func testAppendString() {
        var str = ""
        str = str.append(aString: "usr", with: "/")
        XCTAssertTrue(str == "usr", "the result should be 'usr'")
        
        str = str.append(aString: "root", with: "/")
        XCTAssertTrue(str == "usr/root", "the result should be 'usr/root'")
        
        str = str.append(aString: "", with: "/")
        XCTAssertTrue(str == "usr/root", "the result should be 'usr/root'")
        
        str += "/"
        str = str.append(aString: "desktop", with: "/", suffixSensitive:true)
        XCTAssertTrue(str == "usr/root/desktop", "the result should be 'usr/root'")
        
    }
    
    
}
