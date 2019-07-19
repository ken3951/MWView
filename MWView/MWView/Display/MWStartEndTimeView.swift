//
//  MWStartEndTimeView.swift
//  MWView
//
//  Created by mwk_pro on 2019/6/27.
//  Copyright © 2019 mwk. All rights reserved.
//

import UIKit

public class MWTimeVO: NSObject {
    var hour: Int = 0
    var minute: Int = 0
}

public class MWStartEndTimeView: UIView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    public typealias Callback = (_ beginTime: MWTimeVO, _ beginTime: MWTimeVO) -> Void
    
    public class Config: NSObject {
        ///遮罩层背景色
        public var coverBGColor = UIColor.black.withAlphaComponent(0.6)
        
        ///弹窗背景色
        public var pickViewBGColor = UIColor.white
        ///弹窗高度
        public var pickViewHeight: CGFloat = 280
        ///pickView cell行高
        public var pickViewRowHeight: CGFloat = 30
        
        ///确认按钮背景色
        public var buttonBgColor = UIColor.mw_colorFromHex(hexColor:"009d8e")
        ///确认按钮字体
        public var buttonFont: UIFont = UIFont.systemFont(ofSize: 16)
        ///确认按钮文字颜色
        public var buttonTitleColor = UIColor.white
        
        
        ///显示标题的字体
        public var TitleFont: UIFont = UIFont.systemFont(ofSize: 17)
        ///显示标题的文字颜色
        public var TitleColor = UIColor.mw_colorFromRGB(51, 51, 51)
        
        ///文字内容字体
        public var textFont: UIFont = UIFont.systemFont(ofSize: 16)
        ///文字内容颜色
        public var textColor: UIColor = UIColor.mw_colorFromRGB(51, 51, 51)
        
    }
    
    public let config = Config()

    var startTimePickView : UIPickerView!
    var endTimePickView : UIPickerView!
    
    var contentView : UIView!
    
    var startTime: MWTimeVO!
    
    var endTime: MWTimeVO!
    
    var completionBlock : Callback?
    
    static func showIn(view: UIView?,
                       startTime: MWTimeVO,
                       endTime: MWTimeVO,
                       completion:@escaping Callback) -> Void {
        if view == nil {
            return
        }
        let selfView = MWStartEndTimeView().mw_frame(CGRect(x: 0, y: 0, width: MW_SCREEN_WIDTH, height: MW_SCREEN_HEIGHT))
        selfView.backgroundColor = selfView.config.coverBGColor
        selfView.startTime = startTime
        selfView.endTime = endTime
        selfView.completionBlock=completion
        view!.addSubview(selfView)
        
        selfView.initUI()
        selfView.loadData()
        selfView.showAnimation()
    }
    
    func initUI() {
        contentView = UIView().mw_bgColor(config.pickViewBGColor)
            .mw_frame(CGRect(x: 0.0, y: Double(self.mw_height), width: Double(self.mw_width), height: Double(config.pickViewHeight)))
            .mw_addToView(self)
        
        var sureBtn = UIButton().mw_font(config.buttonFont)
            .mw_target(self, action: #selector(sureButtonAction(button:)), forControlEvents: .touchUpInside)
            .mw_bgColor(config.buttonBgColor)
            .mw_titleColor(config.buttonTitleColor, state: .normal)
            .mw_title("确定", state: .normal)
            .mw_addToView(contentView)
        
        let size = sureBtn.sizeThatFits(CGSize(width: MW_SCREEN_WIDTH, height: 0))
        let buttonWidth = size.width + 30
        let buttonHeight = size.height
        sureBtn.frame = CGRect(x: self.mw_width - 15 - buttonWidth, y: 12, width: buttonWidth, height: buttonHeight)
        sureBtn = sureBtn.mw_cornerRadius(5.0*buttonWidth/70.0)
        
        var startLabel = UILabel().mw_textColor(config.TitleColor)
            .mw_font(config.TitleFont)
            .mw_text("开始时间")
            .mw_textAlignment(.center)
            .mw_addToView(contentView)
        
        let titleSize = startLabel.sizeThatFits(CGSize(width: MW_SCREEN_WIDTH, height: 0))
        startLabel = startLabel.mw_frame(CGRect(x: 0, y: sureBtn.mw_y + sureBtn.mw_height + 15, width: self.mw_width/2.0, height: titleSize.height + 1))
        
        var endLabel = UILabel().mw_textColor(config.TitleColor)
            .mw_font(config.TitleFont)
            .mw_text("结束时间")
            .mw_textAlignment(.center)
            .mw_addToView(contentView)
        
        endLabel = endLabel.mw_frame(CGRect(x: startLabel.mw_width, y: sureBtn.mw_y + sureBtn.mw_height + 15, width: self.mw_width/2.0, height: titleSize.height + 1))

        
        startTimePickView = UIPickerView.init(frame: CGRect.init(x: 0.0, y: Double(startLabel.mw_y + startLabel.mw_height), width: Double(endLabel.mw_width), height: Double(contentView!.mw_height) - Double(startLabel.mw_y + startLabel.mw_height)))
            .mw_bgColor(config.pickViewBGColor)
            .mw_addToView(contentView)
        startTimePickView?.delegate = self
        startTimePickView?.dataSource = self
        
        endTimePickView = UIPickerView().mw_frame(CGRect(x: startTimePickView.mw_width, y: startTimePickView.mw_y, width: startTimePickView.mw_width, height: startTimePickView.mw_height))
            .mw_bgColor(config.pickViewBGColor)
            .mw_addToView(contentView)
        endTimePickView?.delegate = self
        endTimePickView?.dataSource = self
    }
    
    func loadData() {
        startTimePickView.selectRow(startTime.hour, inComponent: 0, animated: false)
        startTimePickView.selectRow(startTime.minute, inComponent: 1, animated: false)
        
        endTimePickView.selectRow(endTime.hour, inComponent: 0, animated: false)
        endTimePickView.selectRow(endTime.minute, inComponent: 1, animated: false)
        
    }
    
    func showAnimation() {
        UIView.animate(withDuration: 0.3) {
            self.contentView!.mw_y = self.mw_height - self.contentView!.mw_height
        }
    }
    
    func dismissAnimation() {
        UIView.animate(withDuration: 0.3, animations: {
            self.contentView!.mw_y = self.mw_height
        }) { (result) in
            self.removeFromSuperview()
        }
    }
    
    //MARK: --Action
    @objc func sureButtonAction(button:UIButton) {
        self.completionBlock?(startTime,endTime)
        
        self.dismissAnimation()
    }
    
    //MARK: --UIPickerViewDelegate,UIPickerViewDataSource
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return 24
        }
        return 60
    }
    
    public func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let width = self.pickerView(pickerView, widthForComponent: component)
        let rowHeight = self.pickerView(pickerView, rowHeightForComponent: component)
        
        var label : UILabel
        
        if view != nil && view is UILabel {
            label = view as! UILabel
            label.frame = CGRect(x: 0, y: 0, width: width, height: rowHeight)
        }else{
            label = UILabel().mw_font(config.textFont)
                .mw_textAlignment(.center)
                .mw_textColor(config.textColor)
                .mw_bgColor(config.pickViewBGColor)
//                .mw_bgColor(UIColor.blue)
                .mw_frame(CGRect(x: 0, y: 0, width: width, height: rowHeight))
        }
        
        let value = row > 9 ? "\(row)" : "0\(row)"
        switch component {
        case 0:
            label.text = "\(value)"
            break
        case 1:
            label.text = "\(value)"
            break
        default:
            break
        }
        return label
    }
    
    public func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return CGFloat(Int((self.mw_width/2.0 - 5.0)/2.0))
    }
    
    public func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return config.pickViewRowHeight
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        var timeVO: MWTimeVO
        if pickerView == startTimePickView {
            timeVO = startTime
        }else{
            timeVO = endTime
        }
        
        if component == 0 {
            timeVO.hour = row
        }else{
            timeVO.minute = row
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
