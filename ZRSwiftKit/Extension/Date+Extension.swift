//
//  Date+Extension.swift
//  ZRSwiftKit
//
//  Created by jiaxw-mac on 2017/9/7.
//  Copyright © 2017年 jiaxw32. All rights reserved.
//

import Foundation

public let dateFormatYear = "yyyy"

let dateFormatMonth = "MM"

let dateFormatDay = "dd"

public let dateFormatNormal = "yyyy-MM-dd"

public let dateFormatSlash = "yyyy/MM/dd"

public let datetimeFormatNormal = "yyyy-MM-dd HH:mm:ss"

public let dateTimeFormatSlash = "yyyy/MM/dd HH:mm:ss"




// MARK: - init
extension Date{
    init?(_ date: String, format: String = datetimeFormatNormal) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        if let formatDate = dateFormatter.date(from: date) {
            self.init(timeIntervalSince1970: formatDate.timeIntervalSince1970)
        } else {
            return nil
        }
    }
    
    
    init?(year: Int,month: Int,day: Int,hour:Int = 0,minute: Int = 0,second: Int = 0) {
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        components.hour = hour
        components.minute = minute
        components.second = second
        if let date = Calendar.current.date(from: components) {
            self.init(timeIntervalSince1970: date.timeIntervalSince1970)
        } else {
            return nil
        }
    }
}

// MARK: - computer property
extension Date{
    
    var year: Int {
        return Calendar.current.component(.year, from: self)
    }
    
    var month: Int {
        return Calendar.current.component(.month, from: self)
    }
    
    var day: Int {
        return Calendar.current.component(.day, from: self)
    }
    
    var hour: Int {
        return Calendar.current.component(.hour, from: self)
    }
    
    var minute: Int {
        return Calendar.current.component(.minute, from: self)
    }
    
    var second: Int {
        return Calendar.current.component(.second, from: self)
    }
    
    var weekDay: Int {
        return Calendar.current.component(.weekday, from: self)
    }
    
    var cnWeekDay: String? {
        var result: String?
        switch weekDay {
        case 1:
            result = "星期天"
        case 2:
            result = "星期一"
        case 3:
            result = "星期二"
        case 4:
            result = "星期三"
        case 5:
            result = "星期四"
        case 6:
            result = "星期五"
        case 7:
            result = "星期六"
        default:
            break
        }
        return result
    }
    
    var weekOfMonth: Int {
        return Calendar.current.component(.weekOfMonth, from: self)
    }
    
    var weekOfYear: Int {
        return Calendar.current.component(.weekOfYear, from: self)
    }
    
    var firstDayOfMonth: Date {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.day,.month,.year], from: self)
        components.day = 1
        return calendar.date(from: components)!
    }
    
    var lastDayOfMonth: Date {
        let calendar = Calendar.current
        let dayRange = calendar.range(of: .day, in: .month, for: self)
        let dayCount = dayRange!.count
        
        var comp = calendar.dateComponents([.year, .month, .day], from: self)
        comp.day = dayCount
        
        return calendar.date(from: comp)!
    }
}


// MARK: - format and transfrom
extension Date{
    
    func toString(with format:String = datetimeFormatNormal) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    static func format(date: String,inFormat: String = dateTimeFormatSlash,outFormat: String = datetimeFormatNormal) -> String? {
        if let date = Date(date, format: inFormat){
            return date.toString(with: outFormat)
        } else {
            return nil
        }
    }
}
