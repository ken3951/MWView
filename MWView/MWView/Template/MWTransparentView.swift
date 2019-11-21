//
//  MWTransparentView.swift
//  WorkPlatformIOS
//
//  Created by mwk_pro on 2019/1/21.
//  Copyright © 2019 mwk_pro. All rights reserved.
//

import UIKit

public class MWTransparentView: UIView {
    private var windowRect = CGRect.zero
    
    public func addScaningWindow(rect: CGRect, padding: UIEdgeInsets = UIEdgeInsets.zero, fillColor: UIColor = UIColor.black, opacity: Float = 0.6) {
        
        self.backgroundColor = UIColor.clear
        windowRect = CGRect(x: rect.origin.x + padding.left, y: rect.origin.y + padding.top, width: rect.size.width - padding.left - padding.right, height: rect.size.height - padding.top - padding.bottom)
        //最里层镂空
        let roundedRectPath = UIBezierPath(roundedRect: windowRect, cornerRadius: 0)
        
        //最外层背景
        let path = UIBezierPath(rect: self.frame)
        path.append(roundedRectPath)
        path.usesEvenOddFillRule = true
        
        let fillLayer = CAShapeLayer()
        fillLayer.path = path.cgPath
        fillLayer.fillRule = CAShapeLayerFillRule.evenOdd
        fillLayer.fillColor = fillColor.cgColor
        fillLayer.opacity = opacity
        
        self.layer.addSublayer(fillLayer)
    }
}
