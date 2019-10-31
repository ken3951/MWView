//
//  MWTransparentView.swift
//  WorkPlatformIOS
//
//  Created by mwk_pro on 2019/1/21.
//  Copyright © 2019 mwk_pro. All rights reserved.
//

import UIKit

public class MWTransparentView: UIView {
    
    private var timer: Timer?
    private var moveY: CGFloat = 0
    private var distanceY: CGFloat = 0
    private var windowRect = CGRect.zero
    
    public func addScaningWindow(rect: CGRect) {
        
        self.backgroundColor = UIColor.clear
        windowRect = CGRect(x: rect.origin.x + 2, y: rect.origin.y + 2, width: rect.size.width - 4, height: rect.size.height - 4)
        //最里层镂空
        let roundedRectPath = UIBezierPath(roundedRect: windowRect, cornerRadius: 0)
        
        //最外层背景
        let path = UIBezierPath(rect: self.frame)
        path.append(roundedRectPath)
        path.usesEvenOddFillRule = true
        
        let fillLayer = CAShapeLayer()
        fillLayer.path = path.cgPath
        fillLayer.fillRule = CAShapeLayerFillRule.evenOdd
        fillLayer.fillColor = UIColor.black.cgColor
        fillLayer.opacity = 0.6
        
        self.layer.addSublayer(fillLayer)
        
        timer = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(timerFire), userInfo: nil, repeats: true)
        timer?.fire()
        
    }
    
    public func endTimer() {
        timer?.fireDate = Date.distantFuture
        timer?.invalidate()
        timer = nil
    }
    
    @objc private func timerFire() {
        self.setNeedsDisplay()
    }
    
    deinit {
        print("MWTransparentView deinit")
    }
    
    override public func draw(_ rect: CGRect) {
        // 水平扫描线
        let context = UIGraphicsGetCurrentContext()
        context?.beginPath()
        context?.setLineWidth(2)
        context?.setStrokeColor(UIColor.mw_colorFromHex(hexColor:"46d1bf").cgColor)
        // p1, p2 连成水平扫描线;
        moveY += distanceY

        if (moveY >= windowRect.size.height - 2) {
            distanceY = -2;
        } else if (moveY <= 2){
            distanceY = 2;
        }
        
        let p1 = CGPoint(x: windowRect.origin.x, y: windowRect.origin.y + moveY)
        let p2 = CGPoint(x: windowRect.origin.x + windowRect.size.width, y: windowRect.origin.y + moveY)

        context?.move(to: p1)
        context?.addLine(to: p2)
        
        context?.strokePath()

    }
}
