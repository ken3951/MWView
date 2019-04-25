//
//  MWCollectionView.swift
//  WorkPlatformIOS
//
//  Created by mwk_pro on 2018/12/14.
//  Copyright © 2018 mwk_pro. All rights reserved.
//

import UIKit

///不能直接使用，用其子类
public class MWCollectionView: UIView {
    
    public typealias MWCollectionViewCallBack = (_ index: Int) -> Void
    
    public class MWSpaceView: UIView {
        
    }

    ///点击事件回调
    public var callBack: MWCollectionViewCallBack?
    ///横向间距
    public var horizontalLeading: CGFloat = 15
    ///竖向间距
    public var verticalLeading: CGFloat = 15
    ///上下左右边距
    public var padding: UIEdgeInsets = UIEdgeInsets(top: 15.0, left: 15.0, bottom: 15.0, right: 15.0)
    
    ///subview 数组
    public private(set) var childViews: Array<UIView> = []
    
    ///占位view，collectionView没有子view时约束collectionView高度为0
    public var spaceView: MWSpaceView = MWSpaceView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(spaceView)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.addSubview(spaceView)
    }
    
    public func reloadData() {
        
        if childViews.count == 0 {
            //占位view，没有子view时高度控制为0
            setHeightZero()
        }else{
            adjustHeight()
        }
    }
    
    internal func adjustHeight() {
        //占位view，有子view时高度自适应，去掉占位view的约束
        spaceView.mas_remakeConstraints { (make) in
            
        }
    }
    
    internal func setHeightZero() {
        //占位view，没有子view时高度控制为0
        spaceView.mas_remakeConstraints { (make) in
            make?.top.equalTo()(self)
            make?.left.equalTo()(self)
            make?.bottom.equalTo()(self)
            make?.right.equalTo()(self)
            make?.height.equalTo()(0)
        }
    }
    
    ///移除所有子View
    public func removeAllViews() {
        for view in self.subviews {
            if !(view is MWSpaceView) {
                view.removeFromSuperview()
            }
        }
        childViews.removeAll()
        self.reloadData()
    }
    
    ///根据index移除子View
    public func removeChildView(_ at: Int) {
        if at < 0 || at >= childViews.count{
            return
        }
        childViews.remove(at: at)
        self.reloadData()
    }
    
    ///添加子View
    public func addView(_ view: UIView) {
        self.addSubview(view)
        view.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction(tap:)))
        view.addGestureRecognizer(tap)
        childViews.append(view)
    }
    
    ///子View点击事件
    @objc private func tapAction(tap: UITapGestureRecognizer) {
        if let subView = tap.view  {
            if let index = childViews.firstIndex(of: subView) {
                self.callBack?(index)
            }
        }
    }

}
