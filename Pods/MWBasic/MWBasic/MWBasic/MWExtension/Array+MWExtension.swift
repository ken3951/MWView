//
//  Array+MWExtension.swift
//  WorkPlatformIOS
//
//  Created by mwk_pro on 2019/2/27.
//  Copyright © 2019 mwk_pro. All rights reserved.
//

import Foundation

public extension Array {
    func mw_JSONString() -> String {
        if (!JSONSerialization.isValidJSONObject(self)) {
            mw_print_i("无法解析出JSONString")
            return ""
        }
        let data : NSData! = try! JSONSerialization.data(withJSONObject: self, options: []) as NSData?
        let JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue)
        return JSONString! as String
        
    }
    
    func mw_JSONData() -> Data? {
        if (!JSONSerialization.isValidJSONObject(self)) {
            mw_print_i("无法解析出JSONData")
            return nil
        }
        let data : NSData! = try! JSONSerialization.data(withJSONObject: self, options: []) as NSData?
        return data as Data
        
    }
}
