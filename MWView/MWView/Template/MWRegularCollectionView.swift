//
//  MWRegularCollectionView.swift
//  WorkPlatformIOS
//
//  Created by mwk_pro on 2018/12/19.
//  Copyright © 2018 mwk_pro. All rights reserved.
//

import UIKit

//使用MWRegularCollectionView
//let array: Array<String> = dataArray[indexPath.row]
//cell.regularView.removeAllViews()
//for _ in 0..<array.count {
//    let imgView = UIImageView().backgroundColor(.gray)
//    
//    let deleteView = MWDeleteView()
//    deleteView.setDeleteBtnSize(CGSize(width: 30, height: 30))
//    deleteView.setDeleteBtn(isHidden: false)
//    weak var collectionView = cell.regularView
//    deleteView.setDeleteBtnCallBack {[weak deleteView,weak self] in
//        if deleteView != nil {
//            if let index = collectionView?.childViews.firstIndex(of: deleteView!) {
//                self?.dataArray[indexPath.row].remove(at: index)
//                self?.myTableView.reloadRows(at: [indexPath], with: .none)
//            }
//        }
//    }
//    
//    deleteView.addSubview(imgView)
//    
//    cell.regularView.addView(deleteView)
//    
//    imgView.mas_remakeConstraints { (make) in
//        make?.edges.equalTo()(deleteView)
//    }
//}
//cell.regularView.reloadData()
//cell.regularView.callBack = { (index) in
//    print_d(index)
//}

public class MWRegularCollectionView: MWCollectionView {

    ///总列数
    public var totalColumn = 3
    
    ///subview宽高比
    public var aspectRatio: CGFloat = 1.0
    
    ///设置collectionView的格局,当只有4个的时候特殊显示，田字型显示
    public var isFourCollection = false
    
    override public func reloadData() {
        super.reloadData()
        
        assert(totalColumn > 0, "totalColumn不能小于1")

        assert(aspectRatio > 0, "aspectRatio不能小于0")
        
        let totalRow = (childViews.count - 1)/totalColumn + 1
        
        let horizontalSpace = (padding.left + padding.right + CGFloat(totalColumn - 1) * horizontalLeading) * -1
        let widthRatio = 1/CGFloat(totalColumn)
        
        for i in 0..<childViews.count {
            let view = childViews[i]
            let row = i/totalColumn
            let column = i%totalColumn
            view.mas_remakeConstraints { (make) in
                
                //先设置宽高
                make?.width.equalTo()(self)?.with()?.offset()(horizontalSpace*widthRatio)?.multipliedBy()(widthRatio)
                make?.height.equalTo()(view.mas_width)?.multipliedBy()(1/aspectRatio)
                
                if column == 0 {
                    if isFourCollection && childViews.count == 4 && totalColumn > 2 && i == 3 {
                        //田字格局设置
                        let leftView = childViews[2]
                        make?.left.equalTo()(leftView.mas_right)?.with()?.offset()(horizontalLeading)
                    }else{
                        //第一列加左约束相对父视图
                        make?.left.equalTo()(self)?.with()?.offset()(padding.left)
                    }
                }else{
                    if isFourCollection && childViews.count == 4 && totalColumn > 2 && i == 2 {
                        //田字格局设置
                        make?.left.equalTo()(self)?.with()?.offset()(padding.left)
                    }else{
                        //正常格局设置
                        
                        //其他列加左约束相对左边的view
                        let leftView = childViews[i-1]
                        make?.left.equalTo()(leftView.mas_right)?.with()?.offset()(horizontalLeading)
                    }
                }
                
                if row == 0 {
                    if isFourCollection && childViews.count == 4 && totalColumn > 2 && i == 2 {
                        //田字格局设置
                        let upView = childViews[0]
                        make?.top.equalTo()(upView.mas_bottom)?.with()?.offset()(verticalLeading)
                    }else{
                        //第一行加上约束相对父视图
                        make?.top.equalTo()(self)?.with()?.offset()(padding.top)
                    }
                }else{
                    if isFourCollection && childViews.count == 4 && totalColumn > 2 && i == 3 {
                        //田字格局设置
                        let upView = childViews[1]
                        make?.top.equalTo()(upView.mas_bottom)?.with()?.offset()(verticalLeading)
                    }else{
                        //其他行加上约束相对上面的view
                        let upView = childViews[i-totalColumn]
                        make?.top.equalTo()(upView.mas_bottom)?.with()?.offset()(verticalLeading)
                    }
                }
                
                if i == childViews.count - 1 {
                    //最后一个加下约束相对父视图
                    make?.bottom.equalTo()(self)?.with()?.offset()(-padding.bottom)
                }
            }
        }
    }

}
