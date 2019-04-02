//
//  ViewControllerProtocol.swift
//  EOPPad
//
//  Created by mwk_pro on 2018/11/20.
//  Copyright © 2018 mwk_pro. All rights reserved.
//

import Foundation
import UIKit

///快速创建viewController的协议，目前只适用于storyboard
public protocol MWControllerLoadable {
    
}

public extension MWControllerLoadable {
    ///扩展VCLoadable协议并实现
    public static func loadVCWithStoryboard(_ storyboard: String = "Main") -> Self {
        let vc = UIStoryboard.init(name: storyboard, bundle: nil).instantiateViewController(withIdentifier: "\(self)") as! Self
        return vc
    }
}
