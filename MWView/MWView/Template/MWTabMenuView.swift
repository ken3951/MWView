//
//  MWTabMenuView.swift
//  WorkPlatformIOS
//
//  Created by mwk_pro on 2019/1/15.
//  Copyright © 2019 mwk_pro. All rights reserved.
//

import UIKit

public typealias MWTabMenuViewCallBack = (_ page: Int) -> Void

public class MWTabMenuView: UIView {
    var normalTextColor = UIColor.mw_colorFromHex(hexColor:"8a8a8a")
    var highlightedTextColor = UIColor.mw_colorFromHex(hexColor:"009d8e")
    var textFont: UIFont = UIFont.systemFont(ofSize: 16)
    var lineViewWidth: CGFloat?
    var lineViewHeight: CGFloat = 2
    var lineViewColor = UIColor.mw_colorFromHex(hexColor:"009d8e")
    var defaultPage: Int = 0

    private var menuTitleArray: Array<String> = []
    private var menuBtnArray: Array<UIButton> = []
    private var selectedPage = 0
    private var lineView = UIView()
    var callBack: MWTabMenuViewCallBack?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        initUI()
        
    }
    
    private func initUI() {
        
        lineView = lineView.mw_bgColor(lineViewColor).mw_addToView(self)
        
    }
    
    private func loadData() {
        
        selectedPage = 0
        
        self.setNeedsLayout()
        self.layoutIfNeeded()
        
        var contentWidth: CGFloat = 0
        for i in 0..<menuTitleArray.count {
            let title = menuTitleArray[i]
            let btn = UIButton(type: .custom).mw_target(self, action: #selector(menuBtnAction(_:)), forControlEvents: .touchUpInside).mw_title(title, state: .normal)
                .mw_titleColor(normalTextColor, state: .normal).mw_titleColor(highlightedTextColor, state: .selected).mw_addToView(self)
            btn.titleLabel?.font = textFont
            let size = btn.sizeThatFits(CGSize(width: 1000, height: 0))
            contentWidth = contentWidth + size.width
        }
        
        let centerLeading = (self.mw_width - contentWidth)/CGFloat(menuTitleArray.count + 1)
        
        for i in 0..<menuTitleArray.count {
            let title = menuTitleArray[i]
            let btn = UIButton(type: .custom).mw_target(self, action: #selector(menuBtnAction(_:)), forControlEvents: .touchUpInside).mw_title(title, state: .normal)
                .mw_titleColor(normalTextColor, state: .normal).mw_titleColor(highlightedTextColor, state: .selected).mw_addToView(self)
            btn.titleLabel?.font = textFont
            let size = btn.sizeThatFits(CGSize(width: 1000, height: 0))
            var x = centerLeading + size.width/2.0
            if i > 0 {
                x = menuBtnArray[i-1].mw_x + menuBtnArray[i-1].mw_width + centerLeading + size.width/2.0
            }
            btn.center = CGPoint(x: x, y: self.mw_height/2.0)
            btn.bounds = CGRect(x: 0, y: 0, width: size.width + 1.0, height: size.height + 1.0)
            if i == defaultPage {
                btn.isSelected = true
                self.lineView.frame = CGRect(x: btn.mw_x, y: self.mw_height - 2.0, width: btn.mw_width, height: 2.0)
            }
            
            menuBtnArray.append(btn)
        }
    }
    
    @objc private func menuBtnAction(_ btn: UIButton) {
        if let index = menuBtnArray.firstIndex(of: btn) {
            if index == selectedPage {
                return
            }
            
            if index < 0 || index > menuTitleArray.count - 1 {
                return
            }
            
            self.callBack?(index)
        }
    }
    
    private func reloadMenuBtn() {
        for i in 0..<menuBtnArray.count {
            let btn = menuBtnArray[i]
            if i == selectedPage {
                btn.isSelected = true
            }else{
                btn.isSelected = false
            }
        }
    }
    
    public func setLineOffsetValue(_ offsetValue: CGFloat) {

        if let firstBtn = menuBtnArray.first {
            if let lastBtn = menuBtnArray.last {
                let x = offsetValue * (lastBtn.center.x - firstBtn.center.x)
                self.lineView.center.x = firstBtn.center.x + x
                var originPage = Int(offsetValue * CGFloat(menuTitleArray.count - 1))
                let currentPage = Int(offsetValue * CGFloat(menuTitleArray.count - 1) + 0.5)
                if currentPage < 0 || currentPage > menuBtnArray.count - 1 {
                    return
                }
                
                if superview == nil {
                    return
                }
                
                var afterIndex = originPage + 1
                if originPage < 0 {
                    originPage = 0
                }else if originPage > menuBtnArray.count - 1 {
                    originPage = menuBtnArray.count - 1
                }
                if afterIndex < 0 {
                    afterIndex = 0
                }else if afterIndex > menuBtnArray.count - 1 {
                    afterIndex = menuBtnArray.count - 1
                }
                
                let beforeBtn = menuBtnArray[originPage]
                let afterBtn = menuBtnArray[afterIndex]
                let aspect = (offsetValue * CGFloat(menuBtnArray.count - 1) * superview!.mw_width - superview!.mw_width * CGFloat(originPage))/superview!.mw_width
                let width = beforeBtn.mw_width + (afterBtn.mw_width - beforeBtn.mw_width) * aspect
                self.lineView.mw_width = lineViewWidth ?? width
                selectedPage = currentPage
                reloadMenuBtn()
            }
        }
    }
    
    public func getSelectedPage() -> Int {
        return selectedPage
    }
    
    public func setMenuTitleArray(array: Array<String>) {
        if array.count < 2 {
            return
        }
        for btn in menuBtnArray {
            btn.removeFromSuperview()
        }
        menuBtnArray.removeAll()
        menuTitleArray = array
        loadData()
    }
    
    public func getMenuTitleArray() -> Array<String> {
        return menuTitleArray
    }
    
}
