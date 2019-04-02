//
//  BerzierView.swift
//  EOPPad
//
//  Created by mwk_pro on 2018/8/24.
//  Copyright © 2018年 mwk_pro. All rights reserved.
//

import UIKit

public class MWBezierView: UIView, CAAnimationDelegate {

    var animation : CAKeyframeAnimation!
    var animationLayer : CALayer!
    
    
    public static func startBezierAnimation(startPoint: CGPoint, endPoint: CGPoint, inLayer: CALayer) {
        
        let bezierView = MWBezierView()
        bezierView.initView(startPoint: startPoint, endPoint: endPoint, inLayer: inLayer)
    }
    
    func initView(startPoint: CGPoint, endPoint: CGPoint, inLayer: CALayer) {
        animationLayer = CALayer()
        animationLayer.bounds = CGRect(x: 0, y: 0, width: 30, height: 30)
        animationLayer.position = startPoint
        animationLayer.backgroundColor = UIColor.red.cgColor
        animationLayer.cornerRadius = 15
        animationLayer.masksToBounds = true
        
        
        inLayer.addSublayer(animationLayer)
        
        let path = UIBezierPath()
        path.move(to: animationLayer.position)
        path.addQuadCurve(to: endPoint, controlPoint: CGPoint(x: endPoint.x, y: startPoint.y - 160))
        
        animation = CAKeyframeAnimation(keyPath: "position")
        animation.autoreverses = false
        animation.duration = 0.6
        animation.path = path.cgPath
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.rotationMode = CAAnimationRotationMode.rotateAuto
        animation.delegate = self
        animationLayer.add(animation, forKey: "")
    }
    
    //MARK:--CAAnimationDelegate
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        animation.delegate = nil
        self.animationLayer.removeFromSuperlayer()
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
