//
//  TableViewCellProtocol.swift
//  EOPPad
//
//  Created by mwk_pro on 2018/8/7.
//  Copyright © 2018年 mwk_pro. All rights reserved.
//

import Foundation
import UIKit

public protocol MWCellLoadService  {
    
}

public extension MWCellLoadService where Self : UITableViewCell {
    ///在tableview中注册当前cell,通过nib创建
    static func registerIn(_ tableView : UITableView) {
        let cellNib = UINib(nibName: "\(self)", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "\(self)")
    }
    
    ///在tableview中获取可重用cell
    static func getDequeueReusableCellIn(_ tableView : UITableView, indexPath : IndexPath) -> Self {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(self)", for: indexPath) as! Self
        return cell
    }
}

