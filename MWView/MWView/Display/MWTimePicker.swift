//
//  MWPick.swift
//  MWView
//
//  Created by mwk_pro on 2019/6/27.
//  Copyright © 2019 mwk. All rights reserved.
//

import UIKit

public enum MWTimePickType: Int {
    ///年月日
    case dateWithYearToDay          =   101
    ///年月日时分
    case dateWithYearToMinute       =   102
    ///年月日时分
    case dateWithHourToMinute       =   103
}

public enum MWPickType : NSInteger {
    ///时分
    case dateWithHourToMinute       =   103
    ///区域
    case area                       =   104
    ///学历
    case educationLevel             =   105
}

public class MWTimePicker: NSObject {
    public typealias MWDateCallback = (_ date: Date) -> Void

    public static func show(inView view: UIView?,
                                timeType: MWTimePickType,
                                selectDate: Date?,
                                startDate: Date = Date.mw_date(year: 2000, month: 1, day: 1),
                                endDate: Date = Date.mw_date(year: 2100, month: 1, day: 1),
                                completion: @escaping MWDateCallback) -> Void {
        let mwPickView = MWPickerView()
        var currentDate = selectDate ?? Date()

        let titles = getTitles(currentDate: currentDate, startDate: startDate, endDate: endDate, timeType: timeType)
        
        if timeType == MWTimePickType.dateWithYearToDay || timeType == MWTimePickType.dateWithYearToMinute {
            mwPickView.selectCallback = { (mwPickView,indexPath) in
                currentDate = refreshTitles(In: mwPickView, indexPath: indexPath, startDate: startDate, currentDate: currentDate)
            }
        }
        mwPickView.completionCallback = { (indexs) in
            let date = getResultDate(indexs: indexs, timeType: timeType, currentDate: currentDate, startDate: startDate)
            completion(date)
        }
        mwPickView.show(withtitles: titles, inView: mw_getCurrentRootVC()?.view)
        
        loadData(pickView: mwPickView.pickView, timeType: timeType, currentDate: currentDate, startDate: startDate)
    }
    
    ///获取所有标题数组
    public static func getTitles(currentDate: Date, startDate: Date, endDate: Date, timeType: MWTimePickType) -> [[String]] {
        var titles: [[String]] = []
        
        if timeType == MWTimePickType.dateWithYearToDay || timeType == MWTimePickType.dateWithYearToMinute {
            var yearTitles: [String] = []
            for i in 0..<(endDate.mw_year - startDate.mw_year + 1) {
                yearTitles.append("\(startDate.mw_year + i)年")
            }
            titles.append(yearTitles)
            
            var monthTitles: [String] = []
            for i in 0..<12 {
                monthTitles.append("\(i+1)月")
            }
            titles.append(monthTitles)
            
            var dayTitles: [String] = []
            for i in 0..<currentDate.mw_numberOfDaysInMonth() {
                dayTitles.append("\(i+1)日")
            }
            titles.append(dayTitles)
        }
        
        
        if timeType == MWTimePickType.dateWithYearToMinute || timeType == MWTimePickType.dateWithHourToMinute {
            var hourTitles: [String] = []
            for i in 0..<24 {
                hourTitles.append("\(i)时")
            }
            titles.append(hourTitles)
            
            var minuteTitles: [String] = []
            for i in 0..<60 {
                minuteTitles.append("\(i)分")
            }
            titles.append(minuteTitles)
            
        }
        return titles
    }
    
    ///刷新标题数组内的部分数据
    public static func refreshTitles(In mwPickView: MWPickerView, indexPath: IndexPath, startDate: Date, currentDate: Date) -> Date {
        var newDate: Date = currentDate
        if indexPath.section == 0 {
            let compareDate = Date.mw_date(year: startDate.mw_year + indexPath.row, month: currentDate.mw_month, day: 1, hour: 0, minute: 0)
            if currentDate.mw_day > compareDate.mw_day {
                newDate.mw_day = compareDate.mw_day
            }
            newDate.mw_year = startDate.mw_year + indexPath.row
            var days: [String] = []
            for i in 0..<compareDate.mw_numberOfDaysInMonth() {
                days.append("\(i+1)日")
            }
            mwPickView.titles[2] = days
            mwPickView.pickView.reloadComponent(2)
        }else if indexPath.section == 1 {
            let compareDate = Date.mw_date(year: currentDate.mw_year, month: indexPath.row + 1, day: 1, hour: 0, minute: 0)
            if newDate.mw_day > compareDate.mw_day {
                newDate.mw_day = compareDate.mw_day
            }
            newDate.mw_month = indexPath.row + 1
            var days: [String] = []
            for i in 0..<compareDate.mw_numberOfDaysInMonth() {
                days.append("\(i+1)日")
            }
            mwPickView.titles[2] = days
            mwPickView.pickView.reloadComponent(2)
        }else if indexPath.section == 2 {
            newDate.mw_day = indexPath.row + 1
        }
        return newDate
    }
    
    ///加载默认选中项
    public static func loadData(pickView: UIPickerView, timeType: MWTimePickType, currentDate: Date, startDate: Date) {
        if timeType == MWTimePickType.dateWithYearToDay || timeType == MWTimePickType.dateWithYearToMinute {
            pickView.selectRow(currentDate.mw_year - startDate.mw_year, inComponent: 0, animated: false)
            pickView.selectRow(currentDate.mw_month - 1, inComponent: 1, animated: false)
            pickView.selectRow(currentDate.mw_day - 1, inComponent: 2, animated: false)
            if timeType == MWTimePickType.dateWithYearToMinute {
                pickView.selectRow(currentDate.mw_hour, inComponent: 3, animated: false)
                pickView.selectRow(currentDate.mw_minute, inComponent: 4, animated: false)
            }
            return
        }
        
        if timeType == MWTimePickType.dateWithHourToMinute {
            pickView.selectRow(currentDate.mw_hour, inComponent: 0, animated: false)
            pickView.selectRow(currentDate.mw_minute, inComponent: 1, animated: false)
        }
    }
    
    ///获取结果date
    public static func getResultDate(indexs: [Int], timeType: MWTimePickType, currentDate: Date, startDate: Date) -> Date {
        var year: Int?
        var month: Int?
        var day: Int?
        var hour: Int?
        var minute: Int?
        
        for i in 0..<indexs.count {
            let value = indexs[i]
            if timeType == MWTimePickType.dateWithYearToDay || timeType == MWTimePickType.dateWithYearToMinute {
                if i == 0 {
                    year = startDate.mw_year + value
                    continue
                }
                if i == 1 {
                    month = value + 1
                    continue
                }
                if i == 2 {
                    day = value + 1
                    continue
                }
                if i == 3 {
                    hour = value
                    continue
                }
                if i == 4 {
                    minute = value
                    continue
                }
                continue
            }
            
            if timeType == MWTimePickType.dateWithHourToMinute {
                if i == 0 {
                    hour = value
                    continue
                }
                if i == 1 {
                    minute = value
                    continue
                }
                continue
            }
            
        }
        let date = Date.mw_date(year: year ?? currentDate.mw_year, month: month ?? currentDate.mw_month, day: day ?? currentDate.mw_day, hour: hour ?? currentDate.mw_hour, minute: minute ?? currentDate.mw_minute)
        return date
    }

}
