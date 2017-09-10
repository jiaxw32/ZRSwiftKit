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
        formatter.dateFormat = datetimeFormatNormal
        let date2 = formatter.date(from: datetime)
        
        XCTAssertEqual(date1, date2)
        
        let date3 = Date("time")
        XCTAssertNil(date3,"the result should be nil")
        
    }
    
    func testInitDateWithYearMonthAndDay() -> Void {
        let date1 = Date(year: year, month: month, day: day)
        XCTAssertNotNil(date1,"date should not be nil")
        
        let date2 = Date(year: year, month: month, day: day, hour: hour, minute: minute, second: second)
        XCTAssertNotNil(date2,"date shouldn't be nil")
        
        let formatter = DateFormatter()
        formatter.dateFormat = datetimeFormatNormal
        let date3 = formatter.date(from: datetime)
        
        XCTAssertEqual(date2, date3,"date2 should be equal to date3")
    }
    
    func testYear() {
        let date = Date(datetime)
        XCTAssertTrue(date!.year == year,"year of the date '\(datetime)' should be equal \(year)")
    }
    
    func testMonth() {
        let date = Date(datetime)
        XCTAssertTrue(date!.month == month,"month of the date '\(datetime)' should be equal \(month)")
    }
    
    func testDay() {
        let date = Date(datetime)!
        XCTAssertTrue(date.day == day,"day of the date '\(datetime)' should be equal \(day)")
    }
    
    func testHour() {
        let date = Date(datetime)!
        XCTAssertTrue(date.hour == hour,"hour of the date '\(datetime)' should be equal \(hour)")
    }
    
    func testMinute() {
        let date = Date(datetime)!
        XCTAssertTrue(date.minute == minute,"minute of the date '\(datetime)' should be equal to \(minute)")
    }
    
    func testSecond() {
        let date = Date(datetime)!
        XCTAssertTrue(date.second == second,"second of the date '\(datetime)' should be equal to \(second)")
    }
    
    func testWeekDay() {
        let date = Date(datetime)
        XCTAssertTrue(date!.weekDay == 5,"week day of the date '\(datetime)' should be five")
    }
    
    func testCnWeekDay() {
        let date = Date(datetime)!
        XCTAssertNotNil(date.cnWeekDay)
        XCTAssertTrue(date.cnWeekDay == "星期四","weekday of the date '\(datetime)' should be '星期四'")
    }
    
    func testWeekOfMonth() -> Void {
        let date = Date(datetime)!
        XCTAssertTrue(date.weekOfMonth == 2,"weekOfMonth of the date '\(datetime)' should be two")    //九月第二周
    }
    
    func testFirstDayOfMonth() -> Void {
        let date = Date(datetime)!.firstDayOfMonth
        
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormatNormal
        let strDate = formatter.string(from: date)
        
        XCTAssertEqual(strDate, firstDayOfMonth,"the date's (\(datetime)) first day of the month of the date '\(datetime)' should be \(strDate)")
    }
    
    func testLastDayOfMonth() -> Void {
        let date = Date(datetime)!.lastDayOfMonth
        
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormatNormal
        let strDate = formatter.string(from: date)
        
        XCTAssertEqual(strDate, lastDayOfMonth,"the date's (\(datetime)) last day of the month should be \(strDate)")
    }
    
    func testDateToString() -> Void {
        let date = Date(datetime)!
        let strDate = date.toString(with: dateFormatNormal)
        XCTAssertTrue(strDate == self.date,"the format date string should be \(self.date)")
        
        let strDatetime = date.toString(with: datetimeFormatNormal)
        XCTAssertTrue(strDatetime == datetime,"the format datetime string should be \(datetime)")
    }
    
    func testDateFormat() -> Void {
        let formatDatetime = Date.format(date: datetime2)
        XCTAssertNotNil(formatDatetime,"the result shouldn't be nil")
        XCTAssertTrue(formatDatetime == datetime,"the result should be \(datetime)")
        
        let formatDatetime2 = Date.format(date: datetime,inFormat: datetimeFormatNormal,outFormat: dateFormatNormal)
        XCTAssertTrue(formatDatetime2 == date,"the result should be \(date)")
    }
    
    

    
}
