//
//  MWDeleteView.swift
//  WorkPlatformIOS
//
//  Created by mwk_pro on 2018/12/19.
//  Copyright © 2018 mwk_pro. All rights reserved.
//

import UIKit

public class MWDeleteView: UIView {
    
    public typealias MWDeleteViewCallBack = () -> Void
    
    private var contentView = UIButton()
    private var deleteBtn = UIButton()
    private var callBack: MWDeleteViewCallBack?
    private var isSelected: Bool = false
    
    public var normalBGColor = UIColor.mw_colorFromHex(hexColor:"898889")
    public var selectedBGColor = UIColor.mw_colorFromHex(hexColor:"46d1bf")


    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    override public func addSubview(_ view: UIView) {
        self.contentView.addSubview(view)
    }
    
    private func initUI() {
        contentView.backgroundColor = normalBGColor
        
        contentView.isUserInteractionEnabled = false
        super.addSubview(contentView)
        contentView.mas_remakeConstraints { (make) in
            make?.edges.equalTo()(self)
        }
        addDeleteBtn()
        
        self.clipsToBounds = false
        self.bringSubviewToFront(deleteBtn)
    }
    
    private func addDeleteBtn() {
        super.addSubview(deleteBtn)
        setDeleteBtn(isHidden: true)
        _ = deleteBtn.mw_bgColor(.red)
        deleteBtn.addTarget(self, action: #selector(deleteBtnAction), for: .touchUpInside)
    }
    
    @objc private func deleteBtnAction() {
        self.callBack?()
    }
    
    public func setIsSelected(isSelected: Bool) {
        self.isSelected = isSelected
        if self.isSelected {
            contentView.backgroundColor = selectedBGColor
        }else{
            contentView.backgroundColor = normalBGColor
        }
    }
    
    public func getIsSelected() -> Bool {
        return isSelected
    }
    
    public func setDeleteBtn(isHidden: Bool) {
        deleteBtn.isHidden = isHidden
    }
    
    public func setBorder(width: CGFloat, color: UIColor) {
        _ = contentView.mw_border(width, color)
    }
    
    public func setCornerRadius(radius: CGFloat) {
        _ = contentView.mw_cornerRadius(radius)
    }
    
    public func setDeleteBtnSize(_ size: CGSize) {
        _ = deleteBtn.mw_cornerRadius(size.width/2.0)

//        deleteBtn.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        deleteBtn.mas_remakeConstraints { (make) in
            make?.top.equalTo()(self)?.with()?.offset()(-size.height/2.0)
            make?.left.equalTo()(self.mas_right)?.with()?.offset()(-size.width/2.0)
            make?.width.equalTo()(size.width)
            make?.height.equalTo()(size.height)
        }
    }
    
    public func setDeleteBtnImage(_ image: UIImage) {
        deleteBtn.setImage(image, for: .normal)
    }
    
    public func setDeleteBtnCallBack(_ callBack: @escaping MWDeleteViewCallBack) {
        self.callBack = callBack
    }
    
    override public func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if !self.isUserInteractionEnabled || self.isHidden || self.alpha <= 0.01 {
            return nil
        }
        
        var view = super.hitTest(point, with: event)
        
        if view == nil {
            let temPoint = deleteBtn.convert(point, from: self)
            if deleteBtn.bounds.contains(temPoint) {
                view = deleteBtn
            }
        }
        return view
    }
}
