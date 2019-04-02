//
//  PagedScrollView.swift
//  FunCityMerchant_Swift
//
//  Created by mwk_pro on 2017/11/30.
//  Copyright © 2017年 mwk_pro. All rights reserved.
//

import UIKit

public protocol MWMJLoadable {
    
}

public extension MWMJLoadable  where Self : UIScrollView {
    public func addMjHeader(keyTitle: String? = nil, completion:@escaping MJRefreshComponentRefreshingBlock) {
        let mjHeader = MJRefreshNormalHeader.init(refreshingBlock: completion)
        mjHeader?.setTitle(String(format:"下拉刷新%@",keyTitle ?? ""), for: MJRefreshState.idle)
        mjHeader?.setTitle(String(format:"松开刷新%@",keyTitle ?? ""), for: MJRefreshState.pulling)
        self.mj_header = mjHeader
    }
    
    public func addMjFooter(keyTitle: String? = nil, completion:@escaping MJRefreshComponentRefreshingBlock) {
        let mjHeader = MJRefreshBackNormalFooter.init(refreshingBlock: completion)
        mjHeader?.setTitle(String(format:"上拉加载更多%@",keyTitle ?? ""), for: MJRefreshState.idle)
        mjHeader?.setTitle(String(format:"松开加载更多%@",keyTitle ?? ""), for: MJRefreshState.pulling)
        self.mj_footer = mjHeader
    }
}

public class MWPagedScrollView: UIScrollView ,MWMJLoadable {

    public var pageNo = 0
    public var totalPage = 1
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
