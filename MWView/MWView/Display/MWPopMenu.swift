//
//  MWPopMenu.swift
//  MWView
//
//  Created by mwk_pro on 2019/7/4.
//  Copyright © 2019 mwk. All rights reserved.
//

import UIKit

public typealias MWPopMenuCallBack = (_ index: Int?) -> Void

public enum MWPopMenuOrientation: Int {
    case up = 1
    case bottom
}

class MWPopMenu: UIView {
    public class MWPopMenuConfig: NSObject {
        ///填充颜色
        public var fillColor: UIColor = UIColor.black
        
        ///边框颜色
        public var strokeColor: UIColor?
        
        ///边框宽度
        public var strokeWidth: CGFloat = 0
        
        ///三角形的底边长
        public var trigonBottomWidth: CGFloat = 15.0
        
        ///三角形的高
        public var trigonHeight: CGFloat = 8.0
        
        ///三角形 离目标的距离
        public var trigonLeading: CGFloat = 0.0
        
        ///圆角
        public var cornerRadius: CGFloat = 6.0
        
        ///内间距
        public var padding: UIEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        ///item间距
        public var space: CGFloat = 10.0
        
        ///距离父试图左右的最小间距
        public var horizontalLead: CGFloat = 10.0
        
        ///遮罩层背景色
        public var coverBGColor = UIColor.black.withAlphaComponent(0.0)
        
        public var shadowOffset = CGSize(width: 0, height: 5)
        
        public var shadowOpacity: Float = 1.0

        public var shadowRadius: CGFloat = 6

        public var shadowColor: CGColor = UIColor.mw_colorFromRGBA(51, 51, 51, 0.55).cgColor
        
    }
    
    private var targetView: UIView!
    
    private var items:  Array<UIView>!
    
    private var callBack: MWPopMenuCallBack!
    
    private var config: MWPopMenuConfig = MWPopMenuConfig()
    
    private var orientation: MWPopMenuOrientation!
    
    private var mainView: MWPopMenuDrawView!
    
    public static func show(targetView: UIView, config: MWPopMenuConfig? = nil, items: Array<UIView>, orientation: MWPopMenuOrientation, completion: @escaping MWPopMenuCallBack) {

        if getCurrentRootVC()?.view == nil {
            return
        }
        
        for view in getCurrentRootVC()!.view.subviews {
            if view.isKind(of: MWPopMenu.self) {
                return
            }
        }
        
        if items.count == 0 {
            return
        }
        
        let selfView = MWPopMenu()
        selfView.targetView = targetView
        selfView.orientation = orientation
        selfView.items = items
        if config != nil {
            selfView.config = config!
        }
        selfView.callBack = completion
        selfView.frame = CGRect(x: 0, y: 0, width: getCurrentRootVC()!.view.frame.size.width, height: getCurrentRootVC()!.view.frame.size.height)
        getCurrentRootVC()!.view.addSubview(selfView)
        
        selfView.loadData()
    }
    
    private func loadData() {
        
        self.backgroundColor = config.coverBGColor
        
        let fatherView = MWPopMenu.getCurrentRootVC()!.view!
        
        var itemsHeight: CGFloat = 0

        var itemsWidth: CGFloat = 0
        
        for view in items {
            itemsHeight = max(itemsHeight, view.mw_height)
            itemsWidth = itemsWidth + view.mw_width
        }
        
        let mainView_width = itemsWidth + config.padding.left + config.padding.right + config.space * CGFloat(items.count - 1)
        let mainView_height = itemsHeight + config.padding.top + config.padding.bottom + config.trigonHeight
        
        let convertFrame = targetView.convert(targetView.bounds, to: fatherView)
        
        var arrow_x: CGFloat = mainView_width/2.0
        var arrow_y: CGFloat!
        var mainView_x = convertFrame.origin.x + (convertFrame.size.width - mainView_width)/2.0
        if mainView_x < config.horizontalLead {
            arrow_x = max(mainView_width/2.0 - (config.horizontalLead - (convertFrame.origin.x + (convertFrame.size.width - mainView_width)/2.0)), config.strokeWidth/2.0 + config.cornerRadius + config.trigonBottomWidth/2.0)
            mainView_x = config.horizontalLead
        }
        if mainView_x + mainView_width > fatherView.frame.size.width - config.horizontalLead {
            arrow_x = min(mainView_width - config.strokeWidth/2.0 - config.cornerRadius - config.trigonBottomWidth/2.0, mainView_width/2.0 + (mainView_x + mainView_width - fatherView.frame.size.width + config.horizontalLead))
            mainView_x = fatherView.frame.size.width - config.horizontalLead - mainView_width
        }
        
        var mainView_y: CGFloat!
        switch orientation! {
        case .up:
            mainView_y = convertFrame.origin.y - mainView_height - config.trigonLeading
            arrow_y = mainView_height - config.strokeWidth/2.0
            break
        case .bottom:
            mainView_y = convertFrame.origin.y + convertFrame.size.height + config.trigonLeading
            arrow_y = config.strokeWidth/2.0
            break
        }
        
        mainView = MWPopMenuDrawView(frame: CGRect(x: mainView_x, y: mainView_y, width: mainView_width, height: mainView_height), config: config, orientation: orientation, arrowPoint: CGPoint(x: arrow_x, y: arrow_y))
        self.addSubview(mainView)
        
        mainView.layer.shadowOffset = config.shadowOffset
        mainView.layer.shadowOpacity = config.shadowOpacity
        mainView.layer.shadowRadius = config.shadowRadius
        mainView.layer.shadowColor = config.shadowColor
        
        var origin_x = config.padding.left
        for i in 0..<items.count {
            let view = items[i]
            view.isUserInteractionEnabled = true
            view.mw_x = origin_x
            view.mw_y = (mainView_height - config.trigonHeight - view.mw_height)/2.0 + config.trigonHeight
            mainView.addSubview(view)
            let tap = UITapGestureRecognizer(target: self, action: #selector(itemTapAction(_:)))
            view.addGestureRecognizer(tap)
            origin_x = origin_x + view.mw_width + config.space
        }
    }
    
    @objc private func itemTapAction(_ tap: UITapGestureRecognizer) {
        if let view = tap.view, let index = items.index(of: view) {
            self.callBack(index)
        }
    }

    ///获取根控制器
    private static func getCurrentRootVC() -> UIViewController? {
        let currentVC = UIApplication.shared.windows.first?.rootViewController
        return currentVC
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = ((touches as NSSet).anyObject() as AnyObject)
        let point = touch.location(in:self)
        let pathRef = CGMutablePath.init()
        pathRef.move(to: CGPoint(x: mainView.frame.origin.x, y: mainView.frame.origin.y))
        pathRef.addLine(to: CGPoint(x: mainView.frame.origin.x + mainView.frame.size.width, y: mainView.frame.origin.y))
        pathRef.addLine(to: CGPoint(x: mainView.frame.origin.x + mainView.frame.size.width, y: mainView.frame.origin.y + mainView.frame.size.height))
        pathRef.addLine(to: CGPoint(x: mainView.frame.origin.x, y: mainView.frame.origin.y + mainView.frame.size.height))
        pathRef.addLine(to: CGPoint(x: mainView.frame.origin.x, y: mainView.frame.origin.y))
        pathRef.closeSubpath()
        
        if !pathRef.contains(point) {
            self.callBack(nil)
            self.removeFromSuperview()
        }
    }
    
    class MWPopMenuDrawView: UIView {
        
        private var orientation: MWPopMenuOrientation!
        
        private var config: MWPopMenuConfig = MWPopMenuConfig()
        
        private var arrowPoint: CGPoint!
        
        init(frame: CGRect, config: MWPopMenuConfig? = nil, orientation: MWPopMenuOrientation, arrowPoint: CGPoint) {
            super.init(frame: frame)
            self.backgroundColor = UIColor.black.withAlphaComponent(0.0)
            self.orientation = orientation
            self.arrowPoint = arrowPoint
            if config != nil {
                self.config = config!
            }
        }
        
        public required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
        
        private func angle(value: CGFloat) -> CGFloat {
            return CGFloat(Double.pi) * value / 180.0
        }
        
        override func draw(_ rect: CGRect) {
            let bezier = UIBezierPath()
            switch orientation! {
            case .bottom:
                bezier.move(to: arrowPoint)
                let point1 = CGPoint(x: arrowPoint.x + config.trigonBottomWidth/2.0, y: arrowPoint.y + config.trigonHeight)
                bezier.addLine(to: point1)
                let point2 = CGPoint(x: self.frame.size.width - config.cornerRadius - config.strokeWidth/2.0, y: point1.y)
                bezier.addLine(to: point2)
                let circlePoint3 = CGPoint(x: point2.x, y: point1.y + config.cornerRadius)
                bezier.addArc(withCenter: circlePoint3, radius: config.cornerRadius, startAngle: angle(value: 270.0), endAngle: angle(value: 0), clockwise: true)
                let point4 = CGPoint(x: self.frame.size.width - config.strokeWidth/2.0, y: self.frame.size.height - config.cornerRadius - config.strokeWidth/2.0)
                bezier.addLine(to: point4)
                let circlePoint5 = CGPoint(x:point4.x - config.cornerRadius, y: point4.y)
                bezier.addArc(withCenter: circlePoint5, radius: config.cornerRadius, startAngle: angle(value: 0), endAngle: angle(value: 90), clockwise: true)
                let point6 = CGPoint(x: config.strokeWidth/2.0 + config.cornerRadius, y: self.frame.size.height - config.strokeWidth/2.0)
                bezier.addLine(to: point6)
                let circlePoint7 = CGPoint(x: point6.x, y: point6.y - config.cornerRadius)
                bezier.addArc(withCenter: circlePoint7, radius: config.cornerRadius, startAngle: angle(value: 90), endAngle: angle(value: 180), clockwise: true)
                let point8 = CGPoint(x: config.strokeWidth/2.0, y: point1.y + config.cornerRadius)
                bezier.addLine(to: point8)
                let circlePoint9 = CGPoint(x: point8.x + config.cornerRadius, y: point8.y)
                bezier.addArc(withCenter: circlePoint9, radius: config.cornerRadius, startAngle: angle(value: 180), endAngle: angle(value: 270), clockwise: true)
                let point10 = CGPoint(x: point1.x - config.trigonBottomWidth, y: point1.y)
                bezier.addLine(to: point10)
                bezier.addLine(to: arrowPoint)
                
                break
            case .up:
                bezier.move(to: arrowPoint)
                let point1 = CGPoint(x: arrowPoint.x - config.trigonBottomWidth/2.0, y: arrowPoint.y - config.trigonHeight)
                bezier.addLine(to: point1)
                let point2 = CGPoint(x: config.cornerRadius + config.strokeWidth/2.0, y: point1.y)
                bezier.addLine(to: point2)
                let circlePoint3 = CGPoint(x: point2.x, y: point1.y - config.cornerRadius)
                bezier.addArc(withCenter: circlePoint3, radius: config.cornerRadius, startAngle: angle(value: 90.0), endAngle: angle(value: 180), clockwise: true)
                let point4 = CGPoint(x: config.strokeWidth/2.0, y: config.cornerRadius + config.strokeWidth/2.0)
                bezier.addLine(to: point4)
                let circlePoint5 = CGPoint(x:point4.x + config.cornerRadius, y: point4.y)
                bezier.addArc(withCenter: circlePoint5, radius: config.cornerRadius, startAngle: angle(value: 180), endAngle: angle(value: 270), clockwise: true)
                let point6 = CGPoint(x: self.frame.size.width - config.strokeWidth/2.0 - config.cornerRadius, y: config.strokeWidth/2.0)
                bezier.addLine(to: point6)
                let circlePoint7 = CGPoint(x: point6.x, y: point6.y + config.cornerRadius)
                bezier.addArc(withCenter: circlePoint7, radius: config.cornerRadius, startAngle: angle(value: 270), endAngle: angle(value: 0), clockwise: true)
                let point8 = CGPoint(x: self.frame.size.width - config.strokeWidth/2.0, y: point1.y - config.cornerRadius)
                bezier.addLine(to: point8)
                let circlePoint9 = CGPoint(x: point8.x - config.cornerRadius, y: point8.y)
                bezier.addArc(withCenter: circlePoint9, radius: config.cornerRadius, startAngle: angle(value: 0), endAngle: angle(value: 90), clockwise: true)
                let point10 = CGPoint(x: point1.x + config.trigonBottomWidth, y: point1.y)
                bezier.addLine(to: point10)
                bezier.addLine(to: arrowPoint)
                break
            }
            config.fillColor.setFill()
            config.strokeColor?.setStroke()
            bezier.lineWidth = config.strokeWidth
            bezier.fill()
            bezier.stroke()
        }
    }
}
