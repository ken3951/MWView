//
//  MWToastView.swift
//  MWBasic
//
//  Created by mwk_pro on 2017/11/29.
//  Copyright © 2017年 mwk_pro. All rights reserved.
//

import Foundation
import UIKit

//toast几种显示的位置
@objc public enum ToastPosition: Int {
    case   bottom = 1001
    case   center = 1002
    case   top = 1003
}


//MARK:--显示toast
public func showToast(message: String) {
    DispatchQueue.main.async {
        MWToastView.show(message: message)
    }
}

public class MWToastView: UIView {
    
    private let titleMaxWidth = MW_SCREEN_WIDTH - 40
    private let padding = UIEdgeInsets(top: 4, left: 10, bottom: 4, right: 10)
    
    private var tip : String = ""
    private var titleLabel : UILabel!
    private var position : ToastPosition!

    @objc public static func show(message: String, position: ToastPosition = .bottom) {
        
        DispatchQueue.main.async {
            if let window = UIApplication.shared.windows.first {
                let toastView = MWToastView()
                    .mw_bgColor(UIColor.black)
                    .mw_addToView(window)
                
                toastView.position = position
                toastView.tip = message
                toastView.loadData()
                toastView.startAnimation()
            }
        }
    }
    
    func loadData() {
        
        titleLabel = UILabel()
            .mw_text(self.tip)
            .mw_textAlignment(NSTextAlignment.left)
            .mw_textColor(UIColor.white)
            .mw_numberOfLines(0)
            .mw_font(UIFont.systemFont(ofSize: 13.0))
            .mw_bgColor(UIColor.clear)
            .mw_addToView(self)
        
        let size = titleLabel.sizeThatFits(CGSize(width: titleMaxWidth, height: 0))
        titleLabel.frame = CGRect(x: padding.left, y: padding.top, width: size.width + 1, height: size.height + 1)
        
        let width = titleLabel.frame.size.width + padding.left + padding.right
        let height = titleLabel.frame.size.height + padding.top + padding.bottom
        
        var rect : CGRect!
        switch position! {
        case .bottom:
            rect = CGRect(x: (MW_SCREEN_WIDTH-width)/2.0, y: CGFloat(MW_SCREEN_HEIGHT) - CGFloat(height) - CGFloat(34) - CGFloat(60.0), width: width, height: height)
            break
        case .center:
            rect = CGRect(x: (MW_SCREEN_WIDTH-width)/2.0, y: MW_SCREEN_HEIGHT/2.0 - height/2.0, width: width, height: height)
            break
        case .top:
            rect = CGRect(x: (MW_SCREEN_WIDTH-width)/2.0, y: MW_STATUS_HEIGHT, width: width, height: height)
            break
        }

        self.frame = rect
        self.layer.cornerRadius = 5.0
        self.layer.masksToBounds = true
    }
    
    //开始动画，完成后自动消失
    func startAnimation() {
        
        var rect = self.frame
        var alpha = 1.0
        
        switch self.position! {
        case .bottom:
            rect.origin.y -= 30
            alpha = 0
            break
        case .center:
            alpha = 0
            break
        case .top:
            alpha = 0.9
            break
        }
        
        self.animation(toRect:rect, toAlpha: CGFloat(alpha), duration: 2.0) { (completion) in
            self.removeFromSuperview()
        }
    }
}
