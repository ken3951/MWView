//
//  UITextField+MWExtension.swift
//  MWCommonTool
//
//  Created by mwk_pro on 2019/3/28.
//  Copyright © 2019 mwk. All rights reserved.
//

import UIKit

public extension UILabel {
    
    // default is nil
    func mw_text(_ value: String?) -> Self {
        text = value
        return self
    }
    
    // default is nil (system font 17 plain)
    func mw_font(_ value: UIFont!) -> Self {
        font = value
        return self
    }
    
    // default is nil (text draws black)
    func mw_textColor(_ value: UIColor!) -> Self {
        textColor = value
        return self
    }
    
    // default is nil (no shadow)
    func mw_shadowColor(_ value: UIColor?) -> Self {
        shadowColor = value
        return self
    }
    
    // default is CGSizemwke(0, -1) -- a top shadow
    func mw_shadowOffset(_ value: CGSize) -> Self {
        shadowOffset = value
        return self
    }
    
    //    default is NSTextAlignmentLeft
    func mw_textAlignment(_ value: NSTextAlignment) -> Self {
        textAlignment = value
        return self
    }
    
    //    default is 1
    func mw_numberOfLines(_ value: Int) -> Self {
        numberOfLines = value
        return self
    }

    // default is NSLineBreakByTruncatingTail. used for single and multiple lines of text
    func mw_lineBreakMode(_ value: NSLineBreakMode) -> Self {
        lineBreakMode = value
        return self
    }
    
    // the underlying attributed string drawn by the label, if set, the label ignores the properties above.
    // default is nil
    @available(iOS 6.0, *)
    func mw_attributedText(_ value: NSAttributedString?) -> Self {
        attributedText = value
        return self
    }

    // the 'highlight' property is used by subclasses for such things as pressed states. it's useful to mwke it part of the base class as a user property
    // default is nil
    func mw_highlightedTextColor(_ value: UIColor?) -> Self {
        highlightedTextColor = value
        return self
    }

    // default is NO
    func mw_highlighted(_ value: Bool) -> Self {
        isHighlighted = value
        return self
    }

    // default is NO
    // can not be written
    //    public func userInteractionEnabledd(_ value: Bool) -> Self {
    //        userInteractionEnabled = value
    //        return self
    //    }
    
    // default is YES. changes how the label is drawn
    func mw_enabled(_ value: Bool) -> Self {
        isEnabled = value
        return self
    }

    
    


    
}
