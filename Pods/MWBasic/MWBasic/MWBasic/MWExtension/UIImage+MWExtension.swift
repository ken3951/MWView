//
//  UIImage+MWExtension.swift
//  EOPPad
//
//  Created by mwk_pro on 2018/8/6.
//  Copyright © 2018年 mwk_pro. All rights reserved.
//

import Foundation
import UIKit

public extension UIImage {
    enum CombineOrientation {
        case horizontal
        case vertical
    }
    
    //根据图片生成颜色
    static func mw_createImage(color: UIColor) -> UIImage? {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image ?? nil
    }
    
    //根据方向合成图片
    func mw_combine(image: UIImage, orientation: CombineOrientation) -> UIImage {
        var totalWidth : CGFloat!
        var totalHeight : CGFloat!
        var firstImageRect : CGRect!
        var secondImageRect : CGRect!
        
        switch orientation {
        case .horizontal:
            totalHeight = (self.size.height + image.size.height)/2.0
            let firstWidth = totalHeight * self.size.width / self.size.height
            let secondWidth = totalHeight * image.size.width / image.size.height
            totalWidth = firstWidth + secondWidth
            firstImageRect = CGRect(x: 0, y: 0, width: firstWidth, height: totalHeight)
            secondImageRect = CGRect(x: firstWidth, y: 0, width: secondWidth, height: totalHeight)
            break
        case .vertical:
            totalWidth = (self.size.width + image.size.width)/2.0
            let firstHeight = totalWidth * self.size.height / self.size.width
            let secondHeight = totalWidth * image.size.height / image.size.width
            totalHeight = firstHeight + secondHeight
            firstImageRect = CGRect(x: 0, y: 0, width: totalWidth, height: firstHeight)
            secondImageRect = CGRect(x: 0, y: firstHeight, width: totalWidth, height: secondHeight)
            
            break
        }

        // UIGraphicsBeginImageContext(offScreenSize);用这个重绘图片会模糊
        UIGraphicsBeginImageContextWithOptions(CGSize(width: totalWidth, height: totalHeight), false, max(self.scale, image.scale))
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(UIColor.white.cgColor)
        context!.fill(CGRect(x: 0, y: 0, width: totalWidth, height: totalHeight));
        
        self.draw(in: firstImageRect)
        
        image.draw(in: secondImageRect)
        
        let imagez = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
        return imagez!;
    }
    
    //压缩图片到指定大小
    func mw_scalTo(kb: Int) -> UIImage {
        let size = kb * 1024
        var compression = 0.9
        let minCompression = 0.1
        var data = self.jpegData(compressionQuality: CGFloat(compression))
        while data!.count > size && compression > minCompression {
            compression -= 0.1
            self.jpegData(compressionQuality: CGFloat(compression))
        }
        let image = UIImage(data: data!)
        return image!
    }
}
