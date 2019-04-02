//
//  MWAdjustCollectionView.swift
//  WorkPlatformIOS
//
//  Created by mwk_pro on 2019/1/13.
//  Copyright © 2019 mwk_pro. All rights reserved.
//

import UIKit

public class MWAdjustCollectionView: MWCollectionView {
    
    override public func reloadData() {
        super.reloadData()
        
        for i in 0..<childViews.count {
            let view = childViews[i]
            view.mas_remakeConstraints { (make) in
                make?.left.equalTo()(self)?.with()?.offset()(padding.left)
                make?.right.equalTo()(self)?.with()?.offset()(padding.right)

                if i == 0 {
                    //第一行加上约束相对父视图
                    make?.top.equalTo()(self)?.with()?.offset()(padding.top)
                }else{
                    //其他行加上约束相对上面的view
                    let upView = childViews[i-1]
                    make?.top.equalTo()(upView.mas_bottom)?.with()?.offset()(verticalLeading)
                }
                
                if i == childViews.count - 1 {
                    //最后一行第一列加下约束相对父视图
                    make?.bottom.equalTo()(self)?.with()?.offset()(-padding.bottom)
                }
            }
        }
    }
}
