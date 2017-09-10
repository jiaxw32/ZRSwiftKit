//
//  Date+ExtensionTests.swift
//  ZRSwiftKit
//
//  Created by jiaxw-mac on 2017/9/7.
//  Copyright © 2017年 jiaxw32. All rights reserved.
//

import XCTest
@testable import ZRSwiftKit


class Date_ExtensionTests: XCTestCase {
    
    let datetime = "2017-09-07 13:14:15"
    
    let datetime2 = "2017/09/07 13:14:15"
    
    let date = "2017-09-07"
    
    let year: Int = 2017
    
    let month: Int = 9
    
    let day : Int = 7
    
    let hour: Int = 13
    
    let minute: Int = 14
    
    let second: Int = 15
    
    
    
    
    let firstDayOfMonth = "2017-09-01"
    
    let lastDayOfMonth = "2017-09-30"
    
    let dateFormat = "yyyy-MM-dd"
    
    let datetimeFormat = "yyyy-MM-dd HH:mm:ss"
    
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInitDateWithString() {
        let date1 = Date(datetime)
        XCTAssertNotNil(date1)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date2 = formatter.date(from: datetime)
        
        XCTAssertEqual(date1, date2)
        
        let date3 = Date("time")
        XCTAssertNil(date3,"date3 should be nil")
        
    }
    
    func testInitDateWithYearMonthAndDay() -> Void {
        let date1 = Date(year: year, month: month, day: day)
        XCTAssertNotNil(date1,"date should not be nil")
        
        let date2 = Date(year: year, month: month, day: day, hour: hour, minute: minute, second: second)
        XCTAssertNotNil(date2,"date shouldn't be nil")
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date3 = formatter.date(from: datetime)
        
        XCTAssertEqual(date2, date3,"date2 should be equal to date3")
    }
    
    func testYear() {
        let date = Date(datetime)
        XCTAssertTrue(date!.year == 2017)
    }
    
    func testMonth() {
        let date = Date(datetime)
        XCTAssertTrue(date!.month == 9)
    }
    
    func testDay() {
        let date = Date(datetime)!
        XCTAssertTrue(date.day == 7)
    }
    
    func testHour() {
        let date = Date(datetime)!
        XCTAssertTrue(date.hour == 13)
    }
    
    func testMinute() {
        let date = Date(datetime)!
        XCTAssertTrue(date.minute == 14)
    }
    
    func testSecond() {
        let date = Date(datetime)!
        XCTAssertTrue(date.second == 15)
    }
    
    func testWeekDay() {
        let date = Date(datetime)
        XCTAssertTrue(date!.weekDay == 5)
    }
    
    func testCnWeekDay() {
        let date = Date(datetime)!
        XCTAssertNotNil(date.cnWeekDay)
        XCTAssertTrue(date.cnWeekDay == "星期四")
    }
    
    func testWeekOfMonth() -> Void {
        let date = Date(datetime)!
        XCTAssertTrue(date.weekOfMonth == 2)    //九月第二周
    }
    
    func testFirstDayOfMonth() -> Void {
        let date = Date(datetime)!.firstDayOfMonth
        
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        let strDate = formatter.string(from: date)
        
        XCTAssertEqual(strDate, firstDayOfMonth)
    }
    
    func testLastDayOfMonth() -> Void {
        let date = Date(datetime)!.lastDayOfMonth
        
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        let strDate = formatter.string(from: date)
        
        XCTAssertEqual(strDate, lastDayOfMonth)
    }
    
    func testDateToString() -> Void {
        let date = Date(datetime)!
        let strDate = date.toString(with: dateFormat)
        XCTAssertTrue(strDate == self.date)
        
        let strDatetime = date.toString(with: datetimeFormat)
        XCTAssertTrue(strDatetime == datetime)
    }
    
    func tetDateFormat() -> Void {
        let formatDatetime = Date.format(date: datetime)
        XCTAssertTrue(formatDatetime == datetime2)
        
        let formatDatetime2 = Date.format(date: datetime,inFormat: datetimeFormat,outFormat: dateFormat)
        XCTAssertTrue(formatDatetime2 == date)
    }
    
    

    
}
