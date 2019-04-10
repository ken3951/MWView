//
//  MWProgressView.swift
//  OADayReport
//
//  Created by mwk_pro on 2018/3/28.
//  Copyright © 2018年 mwk_pro. All rights reserved.
//

import UIKit

public class MWProgressView: UIView, MWViewProtocol {

    private var tip : String = ""
    private var mainView : UIView!
    private var titleLabel : UILabel!
    private var logoImgView : UIImageView!

    public static func show(message:String, isLandscape: Bool = false ) {
        if let fatherView = mw_getCurrentRootVC()?.view {
            DispatchQueue.main.async {
                var width = SCREEN_WIDTH > SCREEN_HEIGHT ? SCREEN_WIDTH : SCREEN_HEIGHT
                var height = SCREEN_WIDTH > SCREEN_HEIGHT ? SCREEN_HEIGHT : SCREEN_WIDTH
                
                if !isLandscape {
                    width = SCREEN_WIDTH > SCREEN_HEIGHT ? SCREEN_HEIGHT : SCREEN_WIDTH
                    height = SCREEN_WIDTH > SCREEN_HEIGHT ? SCREEN_WIDTH : SCREEN_HEIGHT
                }
                
                let progressView = MWProgressView()
                    .mw_frame(CGRect(x: 0, y: 0, width: width, height: height))
                    .mw_bgColor(UIColor.clear.withAlphaComponent(0.0))
                    .mw_addToView(fatherView)
                
                progressView.tip = message
                progressView.initUI()
                progressView.logoImgView.animation(.y)
            }
        }
    }
    
    public static func show(_ indicatorType: NVActivityIndicatorType = .ballRotateChase,_ color: UIColor? = UIColor.white) {
        if let fatherView = mw_getCurrentRootVC()?.view {
            DispatchQueue.main.async {
                let progressView = MWProgressView()
                    .mw_frame(CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
                    .mw_bgColor(UIColor.clear.withAlphaComponent(0.0))
                    .mw_addToView(fatherView)
                
                progressView.initIndicatorView(indicatorType,color: color)
            }
        }
    }
    
    func initIndicatorView(_ indicatorType: NVActivityIndicatorType,color: UIColor? = UIColor.white) {
        let width = 60
        
        let bgView = UIView().mw_center(CGPoint(x: self.mw_width/2.0, y: self.mw_height/2.0))
            .mw_bounds(CGRect(x: 0, y: 0, width: width, height: width))
            .mw_bgColor(UIColor.clear.withAlphaComponent(0.0)).mw_addToView(self)
        
        let activityIndicatorView = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: width, height: width), type: indicatorType, color: color, padding: 0)
        bgView.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
    }
    
    func initUI() {
        
        let imageWidth = 45
        let imageHeight = 41
        let padding = UIEdgeInsets(top: 8, left: 15, bottom: 8, right: 15)
        let centerPadding = 5
        let tipHeight = 20
        
        
        mainView = UIView()
            .mw_center(CGPoint.init(x: self.mw_width/2.0, y: self.mw_height/2.0))
            .mw_bounds(CGRect.init(x: 0, y: 0, width: imageWidth+Int(padding.left+padding.right), height: imageHeight+centerPadding+tipHeight+Int(padding.top+padding.bottom)))
            .mw_bgColor(UIColor.black.withAlphaComponent(0.7))
            .mw_cornerRadius(5)
            .mw_addToView(self)
        
        logoImgView = UIImageView()
            .mw_bgColor(UIColor.clear)
            .mw_frame(CGRect(x: Int(padding.left), y: Int(padding.top), width: imageWidth, height: imageHeight))
            .mw_image(UIImage(named: "ic_loading_logo"))
            .mw_addToView(mainView)
        
        titleLabel = UILabel()
            .mw_text(self.tip)
            .mw_textAlignment(NSTextAlignment.center)
            .mw_textColor(UIColor.white)
            .mw_font(UIFont.systemFont(ofSize: 12.0))
            .mw_bgColor(UIColor.clear)
            .mw_frame(CGRect(x: 0, y: imageHeight+Int(padding.top)+centerPadding, width: Int(mainView.mw_width), height: 20))
            .mw_addToView(mainView)
    }
    
    public static func dismiss() {
        self.dismiss(inView: mw_getCurrentRootVC()?.view)
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
