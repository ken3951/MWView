//
//  UITextField+MWExtension.swift
//  MWCommonTool
//
//  Created by mwk_pro on 2019/3/28.
//  Copyright © 2019 mwk. All rights reserved.
//

import Foundation

public extension UITextField {
    
    // default is nil
    func mw_text(_ value: String?) -> Self {
        text = value
        return self
    }
    
    func mw_setPlaceholderColor(color: UIColor) -> Self {
        self.setValue(self.font, forKeyPath: "_placeholderLabel.font")
        self.setValue(color, forKeyPath: "_placeholderLabel.textColor")
        return self
    }
    
    // default is nil
    @available(iOS 6.0, *)
    func mw_attributedText(_ value: NSAttributedString?) -> Self {
        attributedText = value
        return self
    }
    
    // default is nil. use opaque black
    func mw_textColor(_ value: UIColor?) -> Self {
        textColor = value
        return self
    }
    
    // default is nil. use system font 12 pt
    func mw_font(_ value: UIFont?) -> Self {
        font = value
        return self
    }
    
    // default is NSLeftTextAlignment
    func mw_textAlignment(_ value: NSTextAlignment) -> Self {
        textAlignment = value
        return self
    }
    
    // default is UITextBorderStyleNone. If set to UITextBorderStyleRoundedRect, custom background images are ignored.
    func mw_borderStyle(_ value: UITextField.BorderStyle) -> Self {
        borderStyle = value
        return self
    }
    
    // applies attributes to the full range of text. Unset attributes act like default values.
    @available(iOS 7.0, *)
    func mw_defaultTextAttributes(_ value: [NSAttributedString.Key : Any]) -> Self {
        defaultTextAttributes = value
        return self
    }
    
    // default is nil. string is drawn 70% gray
    func mw_placeholder(_ value: String?) -> Self {
        placeholder = value
        return self
    }
    
    func mw_returnKeyType(_ value: UIReturnKeyType) -> Self{
        returnKeyType = value
        return self
    }
    
    // default is nil
    @available(iOS 6.0, *)
    func mw_attributedPlaceholder(_ value: NSAttributedString?) -> Self {
        attributedPlaceholder = value
        return self
    }
    
    // default is NO which moves cursor to location clicked. if YES, all text cleared
    func mw_clearsOnBeginEditing(_ value: Bool) -> Self {
        clearsOnBeginEditing = value
        return self
    }
    
    // default is NO. if YES, text will shrink to minFontSize along baseline
    func mw_adjustsFontSizeToFitWidth(_ value: Bool) -> Self {
        adjustsFontSizeToFitWidth = value
        return self
    }
    
    // default is 0.0. actual min may be pinned to something readable. used if adjustsFontSizeToFitWidth is YES
    func mw_minimumFontSize(_ value: CGFloat) -> Self {
        minimumFontSize = value
        return self
    }
    
    // default is nil. weak reference
    func mw_delegate(_ value: UITextFieldDelegate?) -> Self {
        delegate = value
        return self
    }
    
    // default is nil. draw in border rect. image should be stretchable
    func mw_background(_ value: UIImage?) -> Self {
        background = value
        return self
    }
    
    // default is nil. ignored if background not set. image should be stretchable
    func mw_disabledBackground(_ value: UIImage?) -> Self {
        disabledBackground = value
        return self
    }
    
    // default is NO. allows editing text attributes with style operations and pasting rich text
    @available(iOS 6.0, *)
    func mw_allowsEditingTextAttributes(_ value: Bool) -> Self {
        allowsEditingTextAttributes = value
        return self
    }
    
    // automatically resets when the selection changes
    @available(iOS 6.0, *)
    func mw_typingAttributes(_ value: [NSAttributedString.Key : Any]?) -> Self {
        typingAttributes = value
        return self
    }
    
    // You can supply custom views which are displayed at the left or right
    // sides of the text field. Uses for such views could be to show an icon or
    // a button to operate on the text in the field in an application-defined
    // manner.
    //
    // A very common use is to display a clear button on the right side of the
    // text field, and a standard clear button is provided.
    
    
    // sets when the clear button shows up. default is UITextFieldViewModeNever
    func mw_clearButtonMode(_ value: UITextField.ViewMode) -> Self {
        clearButtonMode = value
        return self
    }
    
    // e.g. magnifying glass
    func mw_leftView(_ value: UIView?) -> Self {
        leftView = value
        return self
    }
    
    // sets when the left view shows up. default is UITextFieldViewModeNever
    func mw_leftViewMode(_ value: UITextField.ViewMode) -> Self {
        leftViewMode = value
        return self
    }
    
    // e.g. bookmarks button
    func mw_rightView(_ value: UIView?) -> Self {
        rightView = value
        return self
    }
    
    // sets when the right view shows up. default is UITextFieldViewModeNever
    func mw_rightViewMode(_ value: UITextField.ViewMode) -> Self {
        rightViewMode = value
        return self
    }
    
    // Presented when object becomes first responder.  If set to nil, reverts to following responder chain.  If
    // set while first responder, will not take effect until reloadInputViews is called.
    func mw_inputView(_ value: UIView?) -> Self {
        inputView = value
        return self
    }
    
    func mw_inputAccessoryView(_ value: UIView?) -> Self {
        inputAccessoryView = value
        return self
    }
    
    // defaults to NO. if YES, the selection UI is hidden, and inserting text will replace the contents of the field. changing the selection will automatically set this to NO.
    @available(iOS 6.0, *)
    func mw_clearsOnInsertion(_ value: Bool) -> Self {
        clearsOnInsertion = value
        return self
    }
    
}
