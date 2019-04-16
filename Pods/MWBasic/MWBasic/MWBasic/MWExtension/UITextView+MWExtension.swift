//
//  UITextField+MWExtension.swift
//  MWCommonTool
//
//  Created by mwk_pro on 2019/3/28.
//  Copyright © 2019 mwk. All rights reserved.
//

public extension UITextView {
    
    func mw_text(_ value: String!) -> Self {
        text = value
        return self
    }
    
    func mw_font(_ value: UIFont?) -> Self {
        font = value
        return self
    }
    
    func mw_textColor(_ value: UIColor?) -> Self {
        textColor = value
        return self
    }
    
    // default is NSLeftTextAlignment
    func mw_textAlignment(_ value: NSTextAlignment) -> Self {
        textAlignment = value
        return self
    }
    
    func mw_selectedRange(_ value: NSRange) -> Self {
        selectedRange = value
        return self
    }
    
    func mw_editable(_ value: Bool) -> Self {
        isEditable = value
        return self
    }
    
    // toggle selectability, which controls the ability of the user to select content and interact with URLs & attachments
    @available(iOS 7.0, *)
    func mw_selectable(_ value: Bool) -> Self {
        isSelectable = value
        return self
    }
    
    @available(iOS 3.0, *)
    func mw_dataDetectorTypes(_ value: UIDataDetectorTypes) -> Self {
        dataDetectorTypes = value
        return self
    }
    
    // defaults to NO
    @available(iOS 6.0, *)
    func mw_allowsEditingTextAttributes(_ value: Bool) -> Self {
        allowsEditingTextAttributes = value
        return self
    }
    
    @available(iOS 6.0, *)
    func mw_attributedText(_ value: NSAttributedString!) -> Self {
        attributedText = value
        return self
    }
    
    // automatically resets when the selection changes
    @available(iOS 6.0, *)
    func mw_typingAttributes(_ value: [NSAttributedString.Key : Any]) -> Self {
        typingAttributes = value
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
    func mw_clearsOnInsertion(_ value:Bool) -> Self {
        clearsOnInsertion = value
        return self
    }
    
    // Inset the text container's layout area within the text view's content area
    @available(iOS 7.0, *)
    func mw_textContainerInset(_ value:UIEdgeInsets) -> Self {
        textContainerInset = value
        return self
    }

    // Style for links
    @available(iOS 7.0, *)
    func mw_linkTextAttributes(_ value: [NSAttributedString.Key : Any]!) -> Self {
        linkTextAttributes = value
        return self
    }

}
