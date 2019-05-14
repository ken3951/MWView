//
//  NoDataView.swift
//  FunCityMerchant_Swift
//
//  Created by mwk_pro on 2017/12/15.
//  Copyright © 2017年 mwk_pro. All rights reserved.
//

import UIKit

public class MWNoDataView: UIView {
    
    public class Config: NSObject {
        public var noDataImageName = "mw_ic_no_data"
        public var noDataTitle = "暂无数据"
        public var verticalLeading: CGFloat = 15
        public var font: UIFont = UIFont.systemFont(ofSize: 16)
        public var textColor = mw_textColor_black_3
    }
    
    let config = Config()

    public static func showIn(view: UIView, noDataImageName: String? = nil, noDataTitle: String? = nil) {
        
        for item in view.subviews {
            if item is MWNoDataView {
                return
            }
        }
        
        let selfView = MWNoDataView().mw_userInteractionEnabled(false)
            .mw_addToView(view)
        if noDataImageName != nil {
            selfView.config.noDataImageName = noDataImageName!
        }
        if noDataTitle != nil {
            selfView.config.noDataTitle = noDataTitle!
        }
        selfView.initUI()
        
        selfView.mas_makeConstraints { (make) in
            make?.center.equalTo()(view)
        }
    }
    
    func initUI() {
        var imageWidth: CGFloat = 0.0
        var imageHeight: CGFloat = 0.0
        var contentImage: UIImage?
        
        let bundle = Bundle(for: type(of: self))
        if let image = UIImage(named: config.noDataImageName, in: bundle, compatibleWith: nil) {
            imageWidth = image.size.width
            imageHeight = image.size.height
            contentImage = image
        }
        
        if let image = UIImage(named: config.noDataImageName) {
            imageWidth = image.size.width
            imageHeight = image.size.height
            contentImage = image
        }
        
        let imgView = UIImageView().mw_image(contentImage)
            .mw_contentMode(.scaleAspectFit)
            .mw_addToView(self)
        
        imgView.mas_makeConstraints { (make) in
            make?.top.equalTo()(self)
            make?.width.equalTo()(imageWidth)
            make?.height.equalTo()(imageHeight)
            make?.left.equalTo()(self)
            make?.right.equalTo()(self)
        }
        
        let tipLabel = UILabel().mw_font(config.font)
            .mw_textAlignment(.center)
            .mw_textColor(config.textColor)
            .mw_text(config.noDataTitle)
            .mw_userInteractionEnabled(false)
            .mw_addToView(self)
        
        tipLabel.mas_makeConstraints { (make) in
            make?.top.equalTo()(imgView.mas_bottom)?.offset()(config.verticalLeading)
            make?.centerX.equalTo()(self)
            make?.bottom.equalTo()(self)
        }
    }
    
    public static func removeIn(view:UIView) {
        for item in view.subviews {
            if item is MWNoDataView {
                item.removeFromSuperview()
            }
        }
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
