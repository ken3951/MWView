//
//  MWView.swift
//  EOPPad
//
//  Created by mwk_pro on 2018/9/30.
//  Copyright © 2018年 mwk_pro. All rights reserved.
//

import Foundation

@IBDesignable public class MWNibView: UIView {
    
    ///设置圆角
    @IBInspectable public var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius * FIT_WIDTH
            layer.masksToBounds = true
        }
    }
    
    ///设置边框宽度
    @IBInspectable public var borderWidth: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = borderWidth
            layer.masksToBounds = true
        }
    }
    
    ///设置边框颜色
    @IBInspectable public var borderColor: UIColor = UIColor.black {
        didSet {
            layer.borderColor = borderColor.cgColor
            layer.masksToBounds = true
        }
    }
}
