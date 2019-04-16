//
//  PickView.swift
//  FunCityMerchant_Swift
//
//  Created by mwk_pro on 2017/12/19.
//  Copyright © 2017年 mwk_pro. All rights reserved.
//

import UIKit


public enum PickViewType : NSInteger {
    case dateWithYearToDay          =   101     //年月日
    case dateWithYearToMinute                   //年月日时分
    case dateWithHourToMinute                   //时分
    case area                                   //区域
    case educationLevel                         //学历
}

public class MWPickView: UIView ,UIPickerViewDelegate,UIPickerViewDataSource{
    
    public class Config: NSObject {
        public var buttonBgColor = UIColor.mw_colorFromHex(hexColor:"009d8e")
    }
    
    public let config = Config()
    
    private var pickView : UIPickerView?
    private var contentView : UIView!
    private var currentValue : Any?
    private var completionBlock : MWAnyCallback?
    private var pickViewType : PickViewType?
    private var fatherRect : CGRect!
    
    //dateWithYearMonthDay
    private var startYear = 2000
    
    private var addressArray : Array<Any>?

    private var educationArray = ["小学","初中","高中","中专","大专","本科","硕士","博士"]

    public static func showIn(view: UIView?,
                       pickViewType: PickViewType,
                       dataArray: Array<Any>? = nil,
                       currentValue:Any?,
                       completion:@escaping MWAnyCallback) -> Void {
        if view == nil {
            return
        }
        let selfView = MWPickView().mw_bgColor(UIColor.black.withAlphaComponent(0.6))
            .mw_frame(CGRect(x: 0, y: 0, width: MW_SCREEN_WIDTH, height: MW_SCREEN_HEIGHT))
        selfView.fatherRect = view!.frame
        selfView.pickViewType=pickViewType
        selfView.currentValue=currentValue
        switch pickViewType {
        case .dateWithYearToDay,.dateWithYearToMinute:
            if currentValue == nil {
                selfView.currentValue = Date()
            }
            break
        case .dateWithHourToMinute:
            if currentValue == nil {
                selfView.currentValue = Date(timeIntervalSince1970: 0)
            }
            break
        case .area:
            let data = try? Data(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "mw_area", ofType: "json")!))
            selfView.addressArray = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! Array<Any>
            break
        case .educationLevel:
            if currentValue == nil || (currentValue as! String).count == 0 {
                selfView.currentValue = selfView.educationArray.first
            }else {
                for str in selfView.educationArray {
                    if str == (currentValue as! String) {
                        selfView.currentValue = currentValue
                        break
                    }
                }
                if selfView.currentValue == nil {
                    selfView.currentValue = selfView.educationArray.first
                }
            }
            break
        }
        selfView.completionBlock=completion
        view!.addSubview(selfView)
        
        selfView.initUI()
        selfView.loadData()
        selfView.showAnimation()
    }
    
    func initUI() {
        contentView = UIView().mw_bgColor(UIColor.white)
            .mw_frame(CGRect(x: 0.0, y: Double(self.mw_height), width: Double(self.mw_width), height: Double(280)))
            .mw_addToView(self)
        
        let sureBtn = UIButton().mw_target(self, action: #selector(sureButtonAction(button:)), forControlEvents: .touchUpInside)
            .mw_bgColor(config.buttonBgColor)
            .mw_cornerRadius(5.0)
            .mw_titleColor(.white, state: .normal)
            .mw_title("确定", state: .normal)
            .mw_frame(CGRect(x: self.mw_width-90, y: 12, width: 70, height: 34))
            .mw_addToView(contentView)
        sureBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        
        pickView = UIPickerView.init(frame: CGRect.init(x: 0.0, y: Double(sureBtn.mw_y + sureBtn.mw_height), width: Double(contentView!.mw_width), height: Double(contentView!.mw_height)-Double(sureBtn.mw_y + sureBtn.mw_height)))
            .mw_bgColor(UIColor.white)
            .mw_addToView(contentView)
        pickView?.delegate=self
        pickView?.dataSource=self
        
        
    }
    
    func loadData() {
        switch self.pickViewType! {
        case .dateWithYearToDay:
            if currentValue != nil {
                let currentDate = currentValue! as! Date
                let year_index = currentDate.mw_year-startYear
                let month_index = currentDate.mw_month-1
                let day_index = currentDate.mw_day-1
                pickView?.selectRow(year_index, inComponent: 0, animated: false)
                pickView?.selectRow(month_index, inComponent: 1, animated: false)
                pickView?.selectRow(day_index, inComponent: 2, animated: false)
            }
            break
        case .dateWithYearToMinute:
            if currentValue != nil {
                let currentDate = currentValue! as! Date
                let year_index = currentDate.mw_year-startYear
                let month_index = currentDate.mw_month-1
                let day_index = currentDate.mw_day-1
                let hour_index = currentDate.mw_hour
                let minute_index = currentDate.mw_minute

                pickView?.selectRow(year_index, inComponent: 0, animated: false)
                pickView?.selectRow(month_index, inComponent: 1, animated: false)
                pickView?.selectRow(day_index, inComponent: 2, animated: false)
                pickView?.selectRow(hour_index, inComponent: 3, animated: false)
                pickView?.selectRow(minute_index, inComponent: 4, animated: false)

            }
            break
        case .dateWithHourToMinute:
            if currentValue != nil {
                let currentDate = currentValue! as! Date
                let hour_index = currentDate.mw_hour
                let minute_index = currentDate.mw_minute
                
                pickView?.selectRow(hour_index, inComponent: 0, animated: false)
                pickView?.selectRow(minute_index, inComponent: 1, animated: false)
                
            }
            break
        case .area:
            if currentValue != nil {
                let (x,y,z) = currentValue as! (Int,Int,Int)
                
                pickView?.selectRow(x, inComponent: 0, animated: false)
                pickView?.selectRow(y, inComponent: 1, animated: false)
                pickView?.selectRow(z, inComponent: 2, animated: false)
            }
            break
        case .educationLevel:
            var index = 0

            if currentValue != nil {
                let str = currentValue as! String
                for i in 0..<educationArray.count {
                    if str == educationArray[i] {
                        index = i
                        return
                    }
                }
            }
            
            pickView?.selectRow(index, inComponent: 0, animated: false)

            break
        }
    }
    
    func showAnimation() {
        UIView.animate(withDuration: 0.3) {
            self.contentView!.mw_y=self.mw_height-self.contentView!.mw_height
        }
    }
    
    func dismissAnimation() {
        UIView.animate(withDuration: 0.3, animations: {
            self.contentView!.mw_y=self.mw_height
        }) { (result) in
            self.removeFromSuperview()
        }
    }
    
    //MARK: --Action
    @objc func sureButtonAction(button:UIButton) {
        if self.completionBlock != nil {
            self.completionBlock!(self.currentValue)
        }
        self.dismissAnimation()
    }
    
    //MARK: --UIPickerViewDelegate,UIPickerViewDataSource
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        switch self.pickViewType! {
        case .dateWithYearToDay:
            return 3
        case .dateWithYearToMinute:
            return 5
        case .dateWithHourToMinute:
            return 2
        case .area:
            return 3
        case .educationLevel:
            return 1
        }
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch self.pickViewType! {
        case PickViewType.dateWithYearToDay:
            switch component {
            case 0:
                return 100
            case 1:
                return 12
            case 2:
                let currentDate = currentValue! as! Date
                return currentDate.mw_numberOfDaysInMonth()
            default:
                return 0
            }
        case PickViewType.dateWithYearToMinute:
            switch component {
            case 0:
                return 100
            case 1:
                return 12
            case 2:
                let currentDate = currentValue! as! Date
                return currentDate.mw_numberOfDaysInMonth()
            case 3:
                return 24
            case 4:
                return 60
            default:
                return 0
            }
        case PickViewType.dateWithHourToMinute:
            switch component {
            case 0:
                return 24
            case 1:
                return 60
            default:
                return 0
            }
        case .area:
            let (province_index,city_index,_) = currentValue! as! (Int,Int,Int)

            switch component {
            case 0:
                return addressArray!.count
            case 1:
                let cityArray = (addressArray![province_index] as! Dictionary<String,Any>)["cities"] as! Array<Any>
                return cityArray.count
            case 2:
                let zoneArray = (((addressArray![province_index] as! Dictionary<String,Any>)["cities"] as! Array<Any>)[city_index] as! Dictionary<String,Any>)["area"] as! Array<Any>
                return zoneArray.count
            default:
                return 0
            }
        case .educationLevel:
            return educationArray.count
        }
    }
    
    private func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        switch self.pickViewType! {
        case .dateWithYearToDay,.dateWithYearToMinute:
            var label : UILabel
            
            if view != nil && view is UILabel {
                label = view as! UILabel
            }else{
                label = UILabel().mw_font(UIFont.systemFont(ofSize: 16))
                    .mw_textAlignment(.center)
                    .mw_textColor(mw_textColor_black_3)
                    .mw_bgColor(.white)
                    .mw_frame(CGRect(x: 0, y: 0, width: self.mw_width/CGFloat(pickerView.numberOfComponents), height: 40))
            }
            
            switch component {
            case 0:
                label.text=String(format:"%d年",row+startYear)
                break
            case 1:
                label.text=String(format:"%d月",row+1)
                break
            case 2:
                label.text=String(format:"%d日",row+1)
                break
            case 3:
                label.text=String(format:"%d时",row)
                break
            case 4:
                label.text=String(format:"%d分",row)
                break
            default:
                break
            }
            return label
        case .dateWithHourToMinute:
            var label : UILabel
            
            if view != nil && view is UILabel {
                label = view as! UILabel
            }else{
                label = UILabel().mw_font(UIFont.systemFont(ofSize: 16))
                    .mw_textAlignment(.center)
                    .mw_textColor(mw_textColor_black_3)
                    .mw_bgColor(.white)
                    .mw_frame(CGRect(x: 0, y: 0, width: self.mw_width/CGFloat(pickerView.numberOfComponents), height: 40))
            }
            
            switch component {
            case 0:
                label.text=String(format:"%d时",row)
                break
            case 1:
                label.text=String(format:"%d分",row)
                break
            default:
                break
            }
            return label
        case .area:
            var label : UILabel
            
            if view != nil && view is UILabel {
                label = view as! UILabel
            }else{
                label = UILabel().mw_font(UIFont.systemFont(ofSize: 16))
                    .mw_textAlignment(.center)
                    .mw_textColor(mw_textColor_black_3)
                    .mw_bgColor(.white)
                    .mw_frame(CGRect(x: 0, y: 0, width: self.mw_width/3.0, height: 40))
            }
            let (province_index,city_index,_) = currentValue! as! (Int,Int,Int)
            
            switch component {
            case 0:
                label.text = (addressArray![row] as! Dictionary<String,Any>)["name"] as? String
            case 1:
                let cityArray = (addressArray![province_index] as! Dictionary<String,Any>)["cities"] as! Array<Any>
                label.text = (cityArray[row] as! Dictionary<String,Any>)["name"] as? String

            case 2:
                let zoneArray = (((addressArray![province_index] as! Dictionary<String,Any>)["cities"] as! Array<Any>)[city_index] as! Dictionary<String,Any>)["area"] as! Array<Any>
                label.text = (zoneArray[row] as! Dictionary<String,Any>)["name"] as? String
            default:
                break
            }
            return label
        case .educationLevel:
            var label : UILabel
            
            if view != nil && view is UILabel {
                label = view as! UILabel
            }else{
                label = UILabel().mw_font(UIFont.systemFont(ofSize: 16))
                    .mw_textAlignment(.center)
                    .mw_textColor(mw_textColor_black_3)
                    .mw_bgColor(.white)
                    .mw_frame(CGRect(x: 0, y: 0, width: self.mw_width, height: 40))
            }
            label.text = educationArray[row]
            return label
        }
    }
    
    private func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        switch self.pickViewType! {
        case .dateWithYearToDay,.dateWithYearToMinute,.dateWithHourToMinute:
            return 40
        case .area:
            return 40
        case .educationLevel:
            return 40
        }
    }
    
    private func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch self.pickViewType! {
        case .dateWithYearToDay,.dateWithYearToMinute:
            
            let currentLabel = pickerView.view(forRow: row, forComponent: component) as! UILabel

            switch component {
            case 0:
                let yearStr = currentLabel.text!.replacingOccurrences(of: "年", with: "") as NSString
                let currentDate = currentValue! as! Date
                switch self.pickViewType! {
                case .dateWithYearToDay:
                    self.currentValue = Date.mw_date(year: yearStr.integerValue, month: currentDate.mw_month, day: currentDate.mw_day)
                    break
                case .dateWithYearToMinute:
                    self.currentValue = Date.mw_date(year: yearStr.integerValue, month: currentDate.mw_month, day: currentDate.mw_day, hour: currentDate.mw_hour, minute: currentDate.mw_minute)
                    break
                default:
                    break
                }
                pickerView.reloadComponent(2)
                break
            case 1:
                let monthStr = currentLabel.text!.replacingOccurrences(of: "月", with: "") as NSString
                let dayLabel = pickerView.view(forRow: pickerView.selectedRow(inComponent: component+1), forComponent: component+1) as! UILabel
                let dayStr = dayLabel.text!.replacingOccurrences(of: "日", with: "") as NSString
                let currentDate = currentValue! as! Date
                let date = Date.mw_date(year: currentDate.mw_year, month: monthStr.integerValue, day: 1)
                var day = dayStr.integerValue
                if day > date.mw_numberOfDaysInMonth() {
                    day=date.mw_numberOfDaysInMonth()
                }
                switch self.pickViewType! {
                case .dateWithYearToDay:
                    self.currentValue=Date.mw_date(year: currentDate.mw_year, month: monthStr.integerValue, day: day)
                    break
                case .dateWithYearToMinute:
                    self.currentValue = Date.mw_date(year: currentDate.mw_year, month: monthStr.integerValue, day: currentDate.mw_day, hour: currentDate.mw_hour, minute: currentDate.mw_minute)
                    break
                default:
                    break
                }
                pickerView.reloadComponent(2)
                break
            case 2:
                let dayStr = currentLabel.text!.replacingOccurrences(of: "日", with: "") as NSString
                let currentDate = currentValue! as! Date
                switch self.pickViewType! {
                case .dateWithYearToDay:
                    self.currentValue=Date.mw_date(year: currentDate.mw_year, month: currentDate.mw_month, day: dayStr.integerValue)
                    break
                case .dateWithYearToMinute:
                    self.currentValue = Date.mw_date(year: currentDate.mw_year, month: currentDate.mw_month, day: dayStr.integerValue, hour: currentDate.mw_hour, minute: currentDate.mw_minute)
                    break
                default:
                    break
                }
                break
            case 3:
                let hourStr = currentLabel.text!.replacingOccurrences(of: "时", with: "") as NSString
                let currentDate = currentValue! as! Date
                switch self.pickViewType! {
                case .dateWithYearToMinute:
                    self.currentValue = Date.mw_date(year: currentDate.mw_year, month: currentDate.mw_month, day: currentDate.mw_day, hour: hourStr.integerValue, minute: currentDate.mw_minute)
                    break
                default:
                    break
                }
                break
            case 4:
                let minuteStr = currentLabel.text!.replacingOccurrences(of: "分", with: "") as NSString
                let currentDate = currentValue! as! Date
                switch self.pickViewType! {
                case .dateWithYearToMinute:
                    self.currentValue = Date.mw_date(year: currentDate.mw_year, month: currentDate.mw_month, day: currentDate.mw_day, hour: currentDate.mw_hour, minute: minuteStr.integerValue)
                    break
                default:
                    break
                }
                break
            default:
                break
            }
            break
        case .dateWithHourToMinute:
            let currentLabel = pickerView.view(forRow: row, forComponent: component) as! UILabel
            switch component {
            case 0:
                let hourStr = currentLabel.text!.replacingOccurrences(of: "时", with: "") as NSString
                let currentDate = currentValue! as! Date
                switch self.pickViewType! {
                case .dateWithHourToMinute:
                    self.currentValue = Date.mw_date(year: currentDate.mw_year, month: currentDate.mw_month, day: currentDate.mw_day, hour: hourStr.integerValue, minute: currentDate.mw_minute)
                    break
                default:
                    break
                }
                break
            case 1:
                let minuteStr = currentLabel.text!.replacingOccurrences(of: "分", with: "") as NSString
                let currentDate = currentValue! as! Date
                switch self.pickViewType! {
                case .dateWithHourToMinute:
                    self.currentValue = Date.mw_date(year: currentDate.mw_year, month: currentDate.mw_month, day: currentDate.mw_day, hour: currentDate.mw_hour, minute: minuteStr.integerValue)
                    break
                default:
                    break
                }
                break
            default:
                break
            }
            break
        case .area:
            switch component {
            case 0:
                self.currentValue = (row,0,0)
                pickerView.reloadComponent(1)
                pickerView.reloadComponent(2)
                pickerView.selectRow(0, inComponent: 1, animated: true)
                pickerView.selectRow(0, inComponent: 2, animated: true)
                break
            case 1:
                let (x,_,_) = self.currentValue! as! (Int,Int,Int)
                self.currentValue = (x,row,0)
                pickerView.reloadComponent(2)
                pickerView.selectRow(0, inComponent: 2, animated: true)
                break
            case 2:
                let (x,y,_) = self.currentValue! as! (Int,Int,Int)
                self.currentValue = (x,y,row)
                break
            default:
                break
            }
            break
        case .educationLevel:
            currentValue = educationArray[row]
            break
        }
    }
    
    //MARK: -- Override
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismissAnimation()
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
