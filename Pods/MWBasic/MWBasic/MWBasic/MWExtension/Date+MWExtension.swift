//
//  Date+Extension.swift
//  FunCityMerchant_Swift
//
//  Created by mwk_pro on 2017/12/19.
//  Copyright © 2017年 mwk_pro. All rights reserved.
//

import Foundation

public extension Date {
    public var mw_year : Int {
        get{
            let calendar = Calendar.current
            return calendar.component(.year, from: self)
        }
        set{
            
        }
    }
    
    public var mw_month : Int {
        get{
            let calendar = Calendar.current
            return calendar.component(.month, from: self)
        }
        set{
            
        }
    }
    
    public var mw_day : Int {
        get{
            let calendar = Calendar.current
            return calendar.component(.day, from: self)
        }
        set{
            
        }
    }
    
    public var mw_hour : Int {
        get{
            let calendar = Calendar.current
            return calendar.component(.hour, from: self)
        }
        set{
            
        }
    }
    
    public var mw_minute : Int {
        get{
            let calendar = Calendar.current
            return calendar.component(.minute, from: self)
        }
        set{
            
        }
    }
    
    public var mw_weekday : String {
        get{
            let weekDays = [NSNull.init(),"周日","周一","周二","周三","周四","周五","周六"]as [Any]
            let calendar = NSCalendar.init(calendarIdentifier: .gregorian)
            let timeZone = NSTimeZone.init(name:"Asia/Shanghai")
            calendar?.timeZone = timeZone! as TimeZone
            let calendarUnit = NSCalendar.Unit.weekday
            let theComponents = calendar?.components(calendarUnit, from:self)
            return weekDays[(theComponents?.weekday)!]as! String
        }
        set{
            
        }
    }
    
    public var mw_weekday2 : String {
        get{
            let weekDays = [NSNull.init(),"星期日","星期一","星期二","星期三","星期四","星期五","星期六"]as [Any]
            let calendar = NSCalendar.init(calendarIdentifier: .gregorian)
            let timeZone = NSTimeZone.init(name:"Asia/Shanghai")
            calendar?.timeZone = timeZone! as TimeZone
            let calendarUnit = NSCalendar.Unit.weekday
            let theComponents = calendar?.components(calendarUnit, from:self)
            return weekDays[(theComponents?.weekday)!]as! String
        }
        set{
            
        }
    }
    
    public func mw_numberOfDaysInMonth() -> Int {
        let calendar = Calendar.current
        let days = calendar.range(of: .day, in: .month, for: self)
        return days!.count
    }
    
    public func mw_string(_ format:String) -> String {
        let formatter = DateFormatter.init()
        formatter.dateFormat=format
        let string = formatter.string(from: self)
        return string
    }
    
    //年月日创建date
    public static func mw_date(year:Int, month:Int, day:Int) -> Date {
        let calendar = Calendar.current
        var components = DateComponents.init()
        components.year = year
        components.month = month
        components.day = day
        let date = calendar.date(from: components)
        return date!
    }
    
    //年月日时分创建date
    public static func mw_date(year:Int, month:Int, day:Int, hour:Int, minute:Int) -> Date {
        let calendar = Calendar.current
        var components = DateComponents.init()
        components.year = year
        components.month = month
        components.day = day
        components.hour = hour
        components.minute = minute
        let date = calendar.date(from: components)
        return date!
    }
    
    ///string转date
    public static func mw_date(from string:String, format:String) -> Date {
        let formatter = DateFormatter.init()
        formatter.dateFormat=format
        let date = formatter.date(from: string)
        return date!
    }
    
    ///string,根据timeZone转date
    public static func mw_date(from string:String, format:String, timeZone: Int) -> Date {
        let formatter = DateFormatter.init()
        formatter.dateFormat=format
        formatter.timeZone = TimeZone(secondsFromGMT: timeZone)
        let date = formatter.date(from: string)
        return date!
    }
    
    public static func mw_getPreSevenDate() -> Array<Date> {
        var list : Array<Date> = []
        let todayDate = Date()
        for i in 0...6 {
            var day = todayDate.mw_day - (6 - i)
            
            var month = todayDate.mw_month
            var year = todayDate.mw_year

            if day <= 0 {
                month = month - 1
                if month <= 0 {
                    month = 12
                    year = year - 1
                }
                let tempDate = self.mw_date(year: year, month: month, day: 1)
                let monthDays = tempDate.mw_numberOfDaysInMonth()
                day = monthDays + day
            }
            let indexDate = self.mw_date(year: year, month: month, day: day)
            list.append(indexDate)
        }
        return list
    }
    
    //当天0点时间戳
    public func mw_getTodayStartTimeInterval() -> Int {
        let timeInterval = Int(Date.mw_date(year: self.mw_year, month: self.mw_month, day: self.mw_day).timeIntervalSince1970)
        return timeInterval
    }
    
    //当天23.59分的时间戳
    public func mw_getTodayEndTimeInterval() -> Int {
        let timeInterval = self.mw_getTodayStartTimeInterval() + 24 * 60 * 60 - 1
        return timeInterval
    }
}


