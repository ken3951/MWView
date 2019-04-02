//
//  UserDefaults+Extension.swift
//  OADayReport
//
//  Created by mwk_pro on 2018/3/27.
//  Copyright © 2018年 mwk_pro. All rights reserved.
//

import Foundation

let tokenModelKey = "tokenModelKey"
let userModelKey = "userModelKey"
let positionListVOKey = "positionListVOKey"
let appVersionKey = "appVersion"
let goodsRemarkHistoryKey = "goodsRemarkHistoryKey"
let goodsRemarkHistoryMaxSize = 5

public extension UserDefaults {
    func mw_saveCustomObject(customObject object: NSCoding, key: String) { //2
        let encodedObject = NSKeyedArchiver.archivedData(withRootObject: object)
        self.set(encodedObject, forKey: key)
        self.synchronize()
    }
    
    func mw_getCustomObject(forKey key: String) -> AnyObject? { //3
        let decodedObject = self.object(forKey: key) as? NSData
        if let decoded = decodedObject {
            let object = NSKeyedUnarchiver.unarchiveObject(with: decoded as Data)
            return object as AnyObject
        }
        
        return nil
    }
    
}
