//
//  HeaderDefine.swift
//  FunCityMerchant_Swift
//
//  Created by mwk_pro on 2017/11/8.
//  Copyright © 2017年 mwk_pro. All rights reserved.
//


public let mw_color_gray_da = UIColor.mw_colorFromHex(hexColor:"dadada")
public let mw_color_gray_ac = UIColor.mw_colorFromHex(hexColor:"acacac")
public let mw_color_gray_fa = UIColor.mw_colorFromHex(hexColor:"fafafa")
public let mw_color_gray_f2 = UIColor.mw_colorFromHex(hexColor:"f2f2f2")

public let mw_textColor_black_3 = UIColor.mw_colorFromHex(hexColor:"333333")
public let mw_textColor_gray_8a = UIColor.mw_colorFromHex(hexColor:"8a8a8a")
public let mw_textColor_black_54 = UIColor.mw_colorFromHex(hexColor:"545454")

//控制器默认背景色
public let mw_vc_bg_color = UIColor.mw_colorFromHex(hexColor:"f2f2f2")


//MARK:屏幕宽度、高度、比例、状态栏高度、上间距、下间距
public let SCREEN_WIDTH = UIScreen.main.bounds.size.width
public let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
public let STATUS_HEIGHT = UIApplication.shared.statusBarFrame.size.height
public let FIT_WIDTH = UIScreen.main.bounds.size.width / 375.0
public let FIT_Height = UIScreen.main.bounds.size.height / 667.0

//MARK:BlockDefine
public typealias CallBack = ()->Void
public typealias AnyCallBack = (_ value: Any?) -> Void
public typealias BoolCallBack = (_ result: Bool) -> Void
public typealias IntCallBack = (_ index: Int) -> Void
public typealias ImageCallBack = (_ image: UIImage?) -> Void
public typealias StringCallBack = (_ str: String?) -> Void


//MARK:Protocol
public protocol TitleProtocol {
    var title: String {get}
}

public protocol CodeProtocol {
    var code: String {get}
}

public protocol ColorProtocol {
    var color: UIColor {get}
}

public protocol ImageNameProtocol {
    var imageName: String {get}
}
