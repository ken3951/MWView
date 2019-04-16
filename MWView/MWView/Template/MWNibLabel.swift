//
//  MWNibLabel.swift
//  EOPPad
//
//  Created by mwk_pro on 2018/9/30.
//  Copyright © 2018年 mwk_pro. All rights reserved.
//

import UIKit

@IBDesignable public class MWNibLabel: UILabel {
    
    ///文本字体
    @IBInspectable public var textFont: CGFloat = 17.0 {
        didSet {
            font = UIFont(name: font.fontName , size: textFont * MW_FIT_WIDTH)
        }
    }
    
    ///设置圆角
    @IBInspectable public var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius * MW_FIT_WIDTH
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
