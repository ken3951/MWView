//
//  UIView+Extension.swift
//  Swift_UIView
//
//  Created by mwk_pro on 2017/2/21.
//  Copyright © 2017年 mwk_pro. All rights reserved.
//

import Foundation

extension UIView: MWViewAnimatable {
    
    public var mw_x : CGFloat {
        get {
            return self.frame.origin.x
        }
        set {
            var rect = self.frame
            rect.origin.x=newValue
            self.frame=rect
        }
    }
    
    public var mw_y : CGFloat {
        get {
            return self.frame.origin.y
        }
        set {
            var rect = self.frame
            rect.origin.y=newValue
            self.frame=rect
        }
    }
    
    public var mw_width : CGFloat {
        get {
            return self.frame.size.width
        }
        set {
            var rect = self.frame
            rect.size.width=newValue
            self.frame=rect
        }
    }
    
    public var mw_height : CGFloat {
        get {
            return self.frame.size.height
        }
        set {
            var rect = self.frame
            rect.size.height=newValue
            self.frame=rect
        }
    }
    
    public func mw_frame(_ value: CGRect) -> Self {
        frame = value
        return self
    }
    
    public func mw_center(_ value: CGPoint) -> Self {
        center = value
        return self
    }
    
    public func mw_bounds(_ value: CGRect) -> Self {
        bounds = value
        return self
    }
    
    public func mw_userInteractionEnabled(_ value: Bool) -> Self {
        isUserInteractionEnabled = value
        return self
    }
    
    public func mw_bgColor(_ value: UIColor) -> Self {
        backgroundColor = value
        return self
    }
    
    public func mw_cornerRadius(_ value: CGFloat) -> Self {
        layer.cornerRadius = value
        layer.masksToBounds = true
        return self
    }
    
    public func mw_cornerRadiusHalf() -> Self {
        layer.cornerRadius = frame.height / 2.0
        layer.masksToBounds = true
        return self
    }
    
    public func mw_border(_ width: CGFloat, _ color: UIColor) -> Self {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
        layer.masksToBounds = true
        return self
    }
    
    public func mw_hidden(_ value: Bool) -> Self {
        isHidden = value
        return self
    }
    
    public func mw_tag(_ value: NSInteger) -> Self {
        tag = value
        return self
    }
    
    @discardableResult
    public func mw_addToView(_ value: UIView) -> Self {
        value.addSubview(self)
        return self
    }
}

public enum MWTransformRotation : String {
    case x = "transform.rotation.x"
    case y = "transform.rotation.y"
    case z = "transform.rotation.z"
}

///view动画协议
public protocol MWViewAnimatable {
    
}

public extension MWViewAnimatable where Self : UIView {
    
    //旋转动画
    func animation(_ rotation: MWTransformRotation) {
        DispatchQueue.main.async {
            let animation = CABasicAnimation(keyPath: rotation.rawValue)
            animation.fromValue = (0)
            animation.toValue = (Double.pi*2)
            animation.duration = 2.0
            animation.repeatCount = MAXFLOAT
            self.layer.add(animation, forKey: nil)
        }
    }
    
    ///位移+透明度动画，设置时间,设置动画完成是否移除
    func animation(toRect: CGRect? = nil, toAlpha: CGFloat? = nil, duration: TimeInterval, completion: ((_ compleltion: Bool) ->())?) {
        
        UIView.animate(withDuration: duration, animations: {
            
            if toRect != nil {
                self.frame = toRect!
            }
            if toAlpha != nil {
                self.alpha = toAlpha!
            }
            
        }) { (result) in
            if completion != nil {
                completion!(result)
            }
        }
    }
    
    ///缩放动画
    func createScaleAnimation(duration:Float, fromValue:Float, toValue:Float) -> CABasicAnimation {
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        //        if removeOnCompletion {
        //            scaleAnimation.delegate=self
        //        }
        scaleAnimation.fromValue = (fromValue)
        scaleAnimation.toValue = (toValue)
        scaleAnimation.beginTime = CACurrentMediaTime()
        scaleAnimation.duration = CFTimeInterval(duration)
        scaleAnimation.isRemovedOnCompletion = false
        scaleAnimation.timingFunction = CAMediaTimingFunction.init(name: CAMediaTimingFunctionName.linear)
        scaleAnimation.fillMode = CAMediaTimingFillMode.forwards
        return scaleAnimation
    }
    
}
