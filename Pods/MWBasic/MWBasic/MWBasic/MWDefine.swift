//
//  MWDefine.swift
//  MWBasic
//
//  Created by mwk_pro on 2019/4/4.
//  Copyright © 2019 mwk. All rights reserved.
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
public let MW_SCREEN_WIDTH = UIScreen.main.bounds.size.width
public let MW_SCREEN_HEIGHT = UIScreen.main.bounds.size.height
public let MW_STATUS_HEIGHT = UIApplication.shared.statusBarFrame.size.height
public let MW_FIT_WIDTH = UIScreen.main.bounds.size.width / 375.0
public let MW_FIT_Height = UIScreen.main.bounds.size.height / 667.0

//MARK:BlockDefine
public typealias MWCallback = ()->Void
public typealias MWCGFloatCallback = (_ value: CGFloat?) -> Void
public typealias MWAnyCallback = (_ value: Any?) -> Void
public typealias MWBoolCallback = (_ result: Bool) -> Void
public typealias MWIntCallback = (_ index: Int) -> Void
public typealias MWImageCallback = (_ image: UIImage?) -> Void
public typealias MWStringCallback = (_ str: String?) -> Void


//MARK:Protocol
public protocol MWTitleProtocol {
    var title: String {get}
}

public protocol MWIdProtocol {
    var customId: Int {get}
}

public protocol MWCodeProtocol {
    var code: String {get}
}

public protocol MWColorProtocol {
    var color: UIColor {get}
}

public protocol MWImageNameProtocol {
    var imageName: String {get}
}
