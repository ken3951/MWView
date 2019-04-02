//
//  UITextField+MWExtension.swift
//  MWCommonTool
//
//  Created by mwk_pro on 2019/3/28.
//  Copyright © 2019 mwk. All rights reserved.
//

import UIKit

 public extension UITableView {
        
    public func mw_dataSource(_ value: UITableViewDataSource?) -> Self {
        dataSource = value
        return self
    }

//    public func delegate(_ value: UITableViewDelegate?) -> Self {
//        delegate = value
//        return self
//    }
   
    public func mw_rowHeight(_ value: CGFloat) -> Self {
        rowHeight = value
        return self
    }
    
    public func mw_sectionHeaderHeight(_ value: CGFloat) -> Self {
        sectionHeaderHeight = value
        return self
    }
    
    public func mw_sectionFooterHeight(_ value: CGFloat) -> Self {
        sectionFooterHeight = value
        return self
    }
    
    @available(iOS 7.0, *)
    public func mw_estimatedRowHeight(_ value: CGFloat) -> Self {
        estimatedRowHeight = value
        return self
    }
    
    @available(iOS 7.0, *)
    public func mw_estimatedSectionHeaderHeight(_ value: CGFloat) -> Self {
        estimatedSectionHeaderHeight = value
        return self
    }
    
    @available(iOS 7.0, *)
    public func mw_estimatedSectionFooterHeight(_ value: CGFloat) -> Self {
        estimatedSectionFooterHeight = value
        return self
    }
    
    @available(iOS 7.0, *)
    public func mw_separatorInset(_ value: UIEdgeInsets) -> Self {
        separatorInset = value
        return self
    }
    
    @available(iOS 3.2, *)
    public func mw_backgroundView(_ value: UIView?) -> Self {
        backgroundView = value
        return self
    }
    
    public func mw_sectionIndexMinimumDisplayRowCount(_ value: Int) -> Self {
        sectionIndexMinimumDisplayRowCount = value
        return self
    }

    @available(iOS 6.0, *)
    public func mw_sectionIndexColor(_ value: UIColor?) -> Self {
        sectionIndexColor = value
        return self
    }
    
    @available(iOS 7.0, *)
    public func mw_sectionIndexBackgroundColor(_ value: UIColor?) -> Self {
        sectionIndexBackgroundColor = value
        return self
    }
    
    @available(iOS 6.0, *)
    public func mw_sectionIndexTrackingBackgroundColor(_ value: UIColor?) -> Self {
        sectionIndexTrackingBackgroundColor = value
        return self
    }

    public func mw_separatorStyle(_ value: UITableViewCell.SeparatorStyle) -> Self {
        separatorStyle = value
        return self
    }

    public func mw_separatorColor(_ value: UIColor?) -> Self {
        separatorColor = value
        return self
    }

    @available(iOS 8.0, *)
    public func mw_separatorEffect(_ value: UIVisualEffect?) -> Self {
        separatorEffect = value
        return self
    }

    @available(iOS 9.0, *)
    public func mw_cellLayoutMarginsFollowReadableWidth(_ value: Bool) -> Self {
        cellLayoutMarginsFollowReadableWidth = value
        return self
    }

    public func mw_tableHeaderView(_ value: UIView?) -> Self {
        tableHeaderView = value
        return self
    }
    
    public func mw_tableFooterView(_ value: UIView?) -> Self {
        tableFooterView = value
        return self
    }
    
    @available(iOS 9.0, *)
    public func mw_remembersLastFocusedIndexPath(_ value: Bool) -> Self {
        remembersLastFocusedIndexPath = value
        return self
    }
    
}
