//
//  UIAlertController+Extension.swift
//  FunCityMerchant_Swift
//
//  Created by mwk_pro on 2017/11/20.
//  Copyright © 2017年 mwk_pro. All rights reserved.
//

import Foundation

//MARK:--显示dialog弹窗
public func mw_showAlert(message: String , buttonItems : Array<String> = ["确定"] , indexBlock : MWIntCallback? = nil) {
    DispatchQueue.main.async {
        mw_getCurrentRootVC()?.present(UIAlertController.mw_alertView(message: message, buttonItems: buttonItems, indexBlock: indexBlock), animated: true, completion: nil)
    }
}

public func mw_showActionSheet(title: String?, message: String?, buttonItems : Array<String> = ["确定"] , indexBlock : MWIntCallback? = nil) {
    DispatchQueue.main.async {
        mw_getCurrentRootVC()?.present(UIAlertController.mw_create(title: title, message: message, buttonItems: buttonItems, alertStyle: UIAlertController.Style.actionSheet, indexBlock: indexBlock), animated: true, completion: nil)
    }
}

public extension UIAlertController {
    static func mw_create(title: String?,message: String?,buttonItems: Array<Any>!,alertStyle: UIAlertController.Style!,indexBlock:MWIntCallback?) -> UIAlertController {
        let alertController = self.init(title: title, message: message, preferredStyle: alertStyle)
        for i in 0 ..< buttonItems.count {
            let str:String = buttonItems[i] as! String
            let alertAction = UIAlertAction.init(title: str, style: UIAlertAction.Style.default, handler: { (alertAction) in
                for j in 0 ..< alertController.actions.count {
                    if alertAction == alertController.actions[j] {
                        if indexBlock != nil {
                            indexBlock!(j)
                        }
                    }
                }
            })
            alertController.addAction(alertAction)
        }
        return alertController
    }
    
    //创建alertView弹窗
    static func mw_alertView(message: String?,buttonItems: Array<Any>!,indexBlock:MWIntCallback?) -> UIAlertController {
        return self.mw_create(title: "提示", message: message, buttonItems: buttonItems, alertStyle: UIAlertController.Style.alert, indexBlock: indexBlock)
    }
}
