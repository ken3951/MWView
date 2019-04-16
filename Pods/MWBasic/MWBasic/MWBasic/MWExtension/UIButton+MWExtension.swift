//
//  UIButton+Extension.swift
//  EOPPad
//
//  Created by mwk_pro on 2018/8/6.
//  Copyright © 2018年 mwk_pro. All rights reserved.
//

import Foundation

public enum DisplayOrientation: Int {
    case horizontalImageTitle = 1
    case horizontalTitleImage
    case verticalImageTitle
    case verticalTitleImage
}

public extension UIButton {
    //根据方向和间距同时展示文字，图片
    func mw_display(orientation: DisplayOrientation,space: CGFloat) -> Self {
        var titleEdge : UIEdgeInsets!
        var imageEdge : UIEdgeInsets!
        switch orientation {
        case .horizontalImageTitle:
            titleEdge = UIEdgeInsets(
                top: 0,
                left: CGFloat(space/2.0),
                bottom: 0,
                right: -CGFloat(space/2.0))
            imageEdge = UIEdgeInsets(
                top: 0,
                left: CGFloat(space/2.0),
                bottom: 0,
                right:  CGFloat(space/2.0))
            break
        case .horizontalTitleImage:
            titleEdge = UIEdgeInsets(
                top: 0,
                left: -self.imageView!.frame.size.width - CGFloat(space/2.0),
                bottom: 0,
                right: self.imageView!.frame.size.width)
            imageEdge = UIEdgeInsets(
                top: 0,
                left: self.titleLabel!.intrinsicContentSize.width,
                bottom: 0,
                right:  -self.titleLabel!.intrinsicContentSize.width - CGFloat(space/2.0))
            break
        case .verticalImageTitle:
            titleEdge = UIEdgeInsets(
                top: 0,
                left: -self.imageView!.frame.size.width,
                bottom: -self.imageView!.frame.size.height - CGFloat(space/2.0),
                right: 0)
            imageEdge = UIEdgeInsets(
                top: -self.titleLabel!.intrinsicContentSize.height - CGFloat(space/2.0),
                left: 0,
                bottom: 0,
                right:  -self.titleLabel!.intrinsicContentSize.width)
            break
        case .verticalTitleImage:
            titleEdge = UIEdgeInsets(
                top: 0,
                left: -self.imageView!.frame.size.width,
                bottom: -self.imageView!.frame.size.height - CGFloat(space/2.0),
                right: 0)
            imageEdge = UIEdgeInsets(
                top: -self.titleLabel!.intrinsicContentSize.height - CGFloat(space/2.0),
                left: 0,
                bottom: 0,
                right:  -self.titleLabel!.intrinsicContentSize.width)
            break
        }

        
        self.titleEdgeInsets = titleEdge
        self.imageEdgeInsets = imageEdge
        
        return self
    }
    
    //圆角加边框
    func mw_setCornerBorder(cornerRadius: CGFloat,borderColor: UIColor = UIColor.white,borderWidth: CGFloat = 1) -> Self {
        self.layer.cornerRadius = cornerRadius
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
        self.layer.masksToBounds = true
        return self
    }
    
    // default is nil (system font 17 plain)
    func mw_font(_ value: UIFont!) -> Self {
        titleLabel?.font = value
        return self
    }
    
    // MARK: Button targer
    
    func mw_target(_ target: AnyObject?, action: Selector, forControlEvents: UIControl.Event) -> Self {
        addTarget(target, action: action, for: forControlEvents)
        return self
    }
    
    // MARK: button title
    
    func mw_title(_ value: String, state: UIControl.State) -> Self {
        setTitle(value, for: state)
        return self
    }
    
    func mw_nomalStateTitle(_ value: String) -> Self {
        setTitle(value, for: .normal)
        return self
    }
    
    func mw_highlightedStateTitle(_ value: String) -> Self {
        setTitle(value, for: .highlighted)
        return self
    }
    
    
    func mw_selectedStateTitle(_ value: String) -> Self {
        setTitle(value, for: .selected)
        return self
    }
    
    // MARK: button title color
    
    func mw_titleColor(_ value: UIColor, state: UIControl.State) -> Self {
        setTitleColor(value, for: state)
        return self
    }
    
    func mw_nomalStateTitleColor(_ value: UIColor) -> Self {
        setTitleColor(value, for: .normal)
        return self
    }
    
    func mw_highlightedStateTitleColor(_ value: UIColor) -> Self {
        setTitleColor(value, for: .highlighted)
        return self
    }
    
    func mw_selectedStateTitleColor(_ value: UIColor) -> Self {
        setTitleColor(value, for: .selected)
        return self
    }
    
    // MARK: button title shadow color
    
    func mw_titleShadowColor(_ value: UIColor, state: UIControl.State) -> Self {
        setTitleShadowColor(value, for: state)
        return self
    }
    
    func mw_nomalStateTitleShadowColor(_ value: UIColor) -> Self {
        setTitleShadowColor(value, for: .normal)
        return self
    }
    
    func mw_highlightedStateTitleShadowColor(_ value: UIColor) -> Self {
        setTitleShadowColor(value, for: .highlighted)
        return self
    }
    
    func mw_selectedStateTitleShadowColor(_ value: UIColor) -> Self {
        setTitleShadowColor(value, for: .selected)
        return self
    }
    
    
    // MARK: button image
    
    func mw_image(_ value: UIImage?, state: UIControl.State) -> Self {
        setImage(value, for: state)
        return self
    }
    
    func mw_nomalStateImage(_ value: UIImage) -> Self {
        setImage(value, for: .normal)
        return self
    }
    
    func mw_highlightedStateImage(_ value: UIImage) -> Self {
        setImage(value, for: .highlighted)
        return self
    }
    
    
    func mw_selectedStateImage(_ value: UIImage) -> Self {
        setImage(value, for: .selected)
        return self
    }
    
    // MARK: button background image
    
    func mw_backgroundImage(_ image: UIImage, state: UIControl.State) -> Self {
        setBackgroundImage(image, for: state)
        return self
    }
    
    func mw_nomalStateBackgroundImage(_ value: UIImage) -> Self {
        setBackgroundImage(value, for: .normal)
        return self
    }
    
    func mw_highlightedStateBackgroundImage(_ value: UIImage) -> Self {
        setBackgroundImage(value, for: .highlighted)
        return self
    }
    
    
    func mw_selectedStateBackgroundImage(_ value: UIImage) -> Self {
        setBackgroundImage(value, for: .selected)
        return self
    }
    
    // MARK: button Attributed Title
    
    func mw_attributedTitle(_ attr: NSAttributedString, state: UIControl.State) -> Self {
        setAttributedTitle(attr, for: state)
        return self
    }
    
    func mw_normalStateAttributedTitle(_ attr: NSAttributedString) -> Self {
        setAttributedTitle(attr, for: .normal)
        return self
    }
    
    func mw_selectedStateAttributedTitle(_ attr: NSAttributedString) -> Self {
        setAttributedTitle(attr, for: .selected)
        return self
    }
    
    func mw_highLightedStateAttributedTitle(_ attr: NSAttributedString) -> Self {
        setAttributedTitle(attr, for: .highlighted)
        return self
    }
}
