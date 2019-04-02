//
//  UIImageView+Extension.swift
//  FunCityMerchant_Swift
//
//  Created by mwk_pro on 2017/11/20.
//  Copyright © 2017年 mwk_pro. All rights reserved.
//

import Foundation
import UIKit

public extension UIImageView {
    // default is nil
    public func mw_image(_ value: UIImage?) -> Self {
        image = value
        return self
    }
    
    public func mw_contentMode(_ value: UIView.ContentMode) -> Self {
        contentMode = value
        return self
    }
    
    // default is nil
    @available(iOS 3.0, *)
    public func mw_highlightedImage(_ value: UIImage?) -> Self {
        highlightedImage = value
        return self
    }
    
    // default is NO
    public func mw_highlighted(_ value: Bool) -> Self {
        isHighlighted = value
        return self
    }
    
    // these allow a set of images to be animated. the array may contain multiple copies of the same
    // The array must contain UIImages. Setting hides the single image. default is nil
    public func mw_animationImages(_ value: [UIImage]?) -> Self {
        animationImages = value
        return self
    }
    
    // The array must contain UIImages. Setting hides the single image. default is nil
    @available(iOS 3.0, *)
    public func mw_highlightedAnimationImages(_ value: [UIImage]?) -> Self {
        highlightedAnimationImages = value
        return self
    }
    
    // for one cycle of images. default is number of images * 1/30th of a second (i.e. 30 fps)
    public func mw_animationDuration(_ value: TimeInterval) -> Self {
        animationDuration = value
        return self
    }
    
    // 0 means infinite (default is 0)
    public func mw_animationRepeatCount(_ value: Int) -> Self {
        animationRepeatCount = value
        return self
    }
    
    //    // When tintColor is non-nil, any template images set on the image view will be colorized with that color.
    //    // The tintColor is inherited through the superview hierarchy. See UIView for more information.
    //    @available(iOS 7.0, *)
    //    public func tintColor(_ value: UIColor!) -> Self {
    //        tintColor = value
    //        return self
    //    }
}
