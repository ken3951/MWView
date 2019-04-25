//
//  RelateGoodsView.swift
//  CimenEOPProject
//
//  Created by mwk_pro on 2019/4/11.
//  Copyright © 2019 江德春. All rights reserved.
//

import UIKit
import MWBasic
import MWService

let color_main_green = UIColor.mw_colorFromRGB(75, 206, 194)

class RelateGoodsView: UIView {
    public var padding = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    
    public var contentView: MWDeleteView!
    public var imageView: UIImageView!
    public var titleLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initView()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initView()
    }
    
    func initView() {
        
        contentView = MWDeleteView()
        contentView.normalBGColor = UIColor.clear
        contentView.selectedBGColor = UIColor.mw_colorFromRGB(236, 255, 253)
        contentView.setDeleteBtnSize(CGSize(width: 18, height: 18))
        contentView.setDeleteBtnImage(UIImage(named: "ic_remove")!)
        contentView.setIsSelected(isSelected: true)
        contentView.setBorder(width: 1, color: color_main_green)
        contentView.setCornerRadius(radius: 5)
        contentView.setDeleteBtn(isHidden: false)
        self.addSubview(contentView)
        contentView.mas_makeConstraints { (maker) in
            maker?.top.equalTo()(self)?.offset()(9)
            maker?.bottom.equalTo()(self)?.offset()(0)
            maker?.left.equalTo()(self)?.offset()(0)
            maker?.right.equalTo()(self)?.offset()(-9)
        }
        
        imageView = UIImageView().mw_bgColor(UIColor.darkGray).mw_addToView(contentView)
        imageView.mas_makeConstraints { (maker) in
            maker?.top.equalTo()(contentView)?.offset()(self.padding.top)
            maker?.left.equalTo()(contentView)?.offset()(self.padding.left)
            maker?.bottom.equalTo()(contentView)?.offset()(-self.padding.bottom)
            maker?.width.equalTo()(60)
            maker?.height.equalTo()(60)
        }
        
        titleLabel = UILabel().mw_numberOfLines(0)
            .mw_textColor(color_main_green)
            .mw_font(UIFont.systemFont(ofSize: 13))
            .mw_addToView(contentView)
        titleLabel.mas_makeConstraints { (maker) in
            maker?.top.mas_greaterThanOrEqualTo()(contentView)?.offset()(self.padding.top)
            maker?.left.equalTo()(imageView.mas_right)?.offset()(self.padding.left)
            maker?.bottom.mas_greaterThanOrEqualTo()(contentView)?.offset()(-self.padding.bottom)
            maker?.right.equalTo()(contentView)?.offset()(-self.padding.right)
            maker?.centerY.equalTo()(imageView)
        }
    }

}
