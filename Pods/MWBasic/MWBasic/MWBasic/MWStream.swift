//
//  MWStream.swift
//  MWBasic
//
//  Created by mwk_pro on 2019/4/4.
//  Copyright © 2019 mwk. All rights reserved.
//

import UIKit

public typealias MWStreamEvent = (_ data: Any?, _ streamContinue: @escaping MWStreamContinue) -> Void
public typealias MWStreamContinue = (_ data: Any?) -> Void

public class MWStream: NSObject {
    
    public private(set) var dataValue: Any?
    
    public convenience init(dataValue: Any?) {
        self.init()
        self.dataValue = dataValue
    }
    
    public func execute(_ event: MWStreamEvent) -> MWStream? {
        
        var stream: MWStream? = nil
        
        let streamContinue: MWStreamContinue = {[weak self] (value) in
            stream = self
            self?.dataValue = value
        }
        
        event(self.dataValue,streamContinue)
        
        return stream
        
    }
}
