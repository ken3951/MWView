//
//  MWTextCollectionView.swift
//  WorkPlatformIOS
//
//  Created by mwk_pro on 2018/12/19.
//  Copyright © 2018 mwk_pro. All rights reserved.
//

import UIKit

//使用MWRegularCollectionView
//let array: Array<String> = dataArray[indexPath.row]
//cell.textCollectionView.removeAllViews()
//cell.textCollectionView.maxSize = CGSize(width: tableView.width - 30, height: CGFloat(50 * indexPath.row))
//for i in 0..<array.count {
//
//    let padding = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
//
//    let label = UILabel().textColor(.red)
//        .numberOfLines(0)
//        .font(UIFont.systemFont(ofSize: 16))
//        .text(array[i])
//        .backgroundColor(.gray)
//
//    let size = label.sizeThatFits(CGSize(width: tableView.width - cell.textCollectionView.padding.left - cell.textCollectionView.padding.right - 30 - padding.left - padding.right, height: 0))
//
//    label.frame = CGRect(x: padding.left, y: padding.top, width: size.width, height: size.height)
//
//    let deleteView = MWDeleteView().bounds(CGRect(x: 0, y: 0, width: label.width + padding.left + padding.right, height: label.height + padding.top + padding.bottom))
//    deleteView.setDeleteBtnSize(CGSize(width: 30, height: 30))
//    deleteView.setBorder(width: 0.5, color: .gray)
//    deleteView.setCornerRadius(radius: 5)
//    deleteView.setDeleteBtn(isHidden: false)
//    weak var collectionView = cell.textCollectionView
//    deleteView.setDeleteBtnCallBack {[weak deleteView,weak self] in
//        if deleteView != nil {
//            if let index = collectionView?.childViews.firstIndex(of: deleteView!) {
//                self?.dataArray[indexPath.row].remove(at: index)
//                self?.myTableView.reloadRows(at: [indexPath], with: .none)
//            }
//        }
//    }
//    deleteView.addSubview(label)
//
//    cell.textCollectionView.addView(deleteView)
//
//}
//cell.textCollectionView.reloadData()
//cell.textCollectionView.callBack = { (index) in
//    print_d(index)
//}

public class MWTextCollectionView: MWCollectionView {
    
    public var maxSize: CGSize!
    
    public var adjustHeight: Bool = true
    
    private var lowestView: UIView?
    
    override public func reloadData() {
        super.reloadData()
        
        lowestView = nil
        
        for view in childViews {
            if !self.subviews.contains(view) {
                self.addView(view)
            }
        }
        
        var origin_x = padding.left
        var origin_y = padding.top
        var totalHeight = padding.top
        
        for i in 0..<childViews.count {
            let view = childViews[i]
            
            let size = view.frame.size
            
            assert(maxSize != nil, "MWTextCollectionView未设置maxSize")
            
            if origin_x + size.width + padding.right > maxSize.width {
                //当前行放不下，换行
                origin_x = padding.left
                origin_y = totalHeight + verticalLeading
            }
            
            if origin_y + size.height + padding.bottom > maxSize.height {
                //当显示行数超过屏幕最底部，不显示剩余标签
                for j in i..<childViews.count {
                    childViews[j].removeFromSuperview()
                }
                if i == 0 {
                    //占位view，没有子view时高度控制为0
                    setHeightZero()
                }
                break
            }else{
                
                //可以放置子view，设置子view的frame及约束
                view.frame = CGRect(x: origin_x, y: origin_y, width: size.width, height: size.height)
                view.mas_remakeConstraints { (make) in
                    make?.top.equalTo()(self)?.with()?.offset()(origin_y)
                    make?.left.equalTo()(self)?.with()?.offset()(origin_x)
                    make?.width.equalTo()(size.width)
                    make?.height.equalTo()(size.height)
                    if origin_y + size.height > totalHeight {
                        totalHeight = origin_y + size.height
                        //刷新父视图高度
                        if self.adjustHeight {
                            if lowestView != nil {
                                //还原之前最底部的view的约束
                                lowestView!.mas_remakeConstraints { (make) in
                                    make?.top.equalTo()(self)?.with()?.offset()(lowestView!.mw_y)
                                    make?.left.equalTo()(self)?.with()?.offset()(lowestView!.mw_x)
                                    make?.width.equalTo()(lowestView!.mw_width)
                                    make?.height.equalTo()(lowestView!.mw_height)
                                }
                            }
                            lowestView = view
                            //增加最底部的view的bottom约束
                            make?.bottom.equalTo()(self)?.with()?.offset()(-padding.bottom)
                        }
                    }
                }
                
                //获取下一个子view的origin_x，并刷新totalHeight
                origin_x = origin_x + size.width + horizontalLeading
            }
            
        }
    }
}
