//
//  MWPagedTableView.swift
//  MWView
//
//  Created by mwk_pro on 2019/4/1.
//  Copyright © 2019 mwk. All rights reserved.
//

import UIKit

public class MWPagedTableView: UITableView, MWMJLoadable {

    ///当前加载到第几页,默认为0，未加载
    public var pageNo = 0
    
    ///当前加载的总页数,默认为1
    public var totalPage = 1
    
    ///背景view颜色
    public var bgViewColor : UIColor? {
        willSet{
            
        }
        didSet{
            if bgViewColor != nil {
                self.backgroundView = UIView().mw_frame(CGRect.zero).mw_bgColor(bgViewColor!)
            }
        }
    }
    
    private func initView() {
        self.tableFooterView = UIView().mw_frame(CGRect.zero)
            .mw_bgColor(mw_vc_bg_color)
        if #available(iOS 11.0, *) {
            self.contentInsetAdjustmentBehavior = .never
        }
        self.autoresizingMask = UIView.AutoresizingMask(rawValue: UIView.AutoresizingMask.flexibleHeight.rawValue | UIView.AutoresizingMask.flexibleWidth.rawValue)
        
        adjustRowHeight()
        self.bgViewColor = mw_vc_bg_color
        self.estimatedSectionHeaderHeight = 0
        self.estimatedSectionFooterHeight = 0
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initView()
    }
    
    public func adjustRowHeight(_ rowHeight: CGFloat = 60) {
        self.estimatedRowHeight = rowHeight
        self.rowHeight = UITableView.automaticDimension
    }
    
    
    public override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        initView()
    }
    
//    override init() {
//        super.init()
//    }
    
//    convenience init() {
//        self.init(frame: CGRect.zero, style: UITableView.Style.plain)
//    }
}
