//
//  UIColor+Extension.swift
//  FunCityMerchant_Swift
//
//  Created by mwk_pro on 2017/11/8.
//  Copyright © 2017年 mwk_pro. All rights reserved.
//

import Foundation
import UIKit
public extension UIColor {
    
    //RGB创建颜色
    public static func mw_colorFromRGB(_ r:NSInteger,_ g:NSInteger,_ b:NSInteger) -> UIColor {
        return mw_colorFromRGBA(r, g, b, 1.0)
    }
    
    //RGB创建颜色
    public static func mw_colorFromRGBA(_ r:NSInteger,_ g:NSInteger,_ b:NSInteger,_ alpha:CGFloat) -> UIColor {
        return self.init(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: alpha)
    }
    
    //十六进制色值创建颜色
    public static func mw_colorFromHex(hexColor:String) -> UIColor {
        
        return mw_colorFromHex(hexColor, 1.0)
    }
    
    //十六进制色值创建颜色
    public static func mw_colorFromHex(_ hexColor:String,_ alpha:CGFloat) -> UIColor {
        // 存储转换后的数值
        var red:UInt32 = 0,green:UInt32 = 0,blue:UInt32 = 0
        // 分别转换进行转换
        Scanner(string: hexColor[0..<2]).scanHexInt32(&red)
        
        Scanner(string: hexColor[2..<4]).scanHexInt32(&green)
        
        Scanner(string: hexColor[4..<6]).scanHexInt32(&blue)
        
        return self.init(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: alpha)
    }
    
}
