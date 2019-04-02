//
//  MWPopover.swift
//  WorkPlatformIOS
//
//  Created by mwk on 2019/3/23.
//  Copyright © 2019 mwk_pro. All rights reserved.
//

import UIKit

public typealias MWPopoverCallBack = (_ index: Int) -> Void

public class MWPopoverConfig: NSObject {
    ///popover填充颜色
    public var fillColor: UIColor = UIColor.black
    
    ///popover边框颜色
    public var strokeColor: UIColor?
    
    ///popover边框宽度
    public var strokeWidth: CGFloat = 0
    
    ///popover三角形的底边长
    public var trigonBottomWidth: CGFloat = 6.0
    
    ///popover三角形的高
    public var trigonHeight: CGFloat = 6.0
    
    ///popover三角形 离目标的距离
    public var trigonLeading: CGFloat = 0.0
    
    ///popover圆角
    public var cornerRadius: CGFloat = 6.0
    
    ///popover距离父试图左右的最小间距
    public var horizontalLead: CGFloat = 10.0
    
    ///titleColor
    public var titleColor: UIColor = UIColor.white
    
    ///titleFont
    public var titleFont: UIFont = UIFont.systemFont(ofSize: 14)
    
    ///tableview title 上下左右间距
    public var titleEdge: UIEdgeInsets = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
    
    ///tableview 分割线 上下左右间距
    public var separatorLineEdge: UIEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    
    ///tableview 分割线颜色
    public var separatorLineColor: UIColor = UIColor.white
    
    ///遮罩层背景色
    public var coverBGColor = UIColor.black.withAlphaComponent(0.0)
    
}

public enum MWPopoverOrientation: Int {
    case up = 1
    case bottom
}

public class MWPopover: UIView {
    private var tableView: UITableView!
    
    private var targetView: UIView!
    
    private var titleArray:  Array<String>!
    
    private var callBack: MWPopoverCallBack!
    
    private var config: MWPopoverConfig = MWPopoverConfig()
    
    private var cellSize: CGSize!
    
    private var orientation: MWPopoverOrientation!
    
    private var mainView: MWPopoverDrawView!
    
    public static func show(targetView: UIView, config: MWPopoverConfig? = nil, titleArray: Array<String>, orientation: MWPopoverOrientation, completion: @escaping MWPopoverCallBack) {
        if getCurrentRootVC()?.view == nil {
            return
        }
        
        for view in getCurrentRootVC()!.view.subviews {
            if view.isKind(of: MWPopover.self) {
                return
            }
        }
        
        let selfView = MWPopover()
        selfView.targetView = targetView
        selfView.titleArray = titleArray
        selfView.orientation = orientation
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
        
        let fatherView = MWPopover.getCurrentRootVC()!.view!
        
        let label = getTitleLabel()
        var maxWidth: CGFloat = 0
        var maxHeight: CGFloat = 0
        for title in titleArray {
            label.text = title
            let size = label.sizeThatFits(CGSize(width: fatherView.bounds.size.width - config.titleEdge.left - config.titleEdge.right, height: 0))
            maxWidth = max(size.width + 1, maxWidth)
            maxHeight = max(size.height + 1, maxHeight)
        }
        cellSize = CGSize(width: Int(maxWidth + config.titleEdge.left + config.titleEdge.right) + 1, height: Int(maxHeight + config.titleEdge.top + config.titleEdge.bottom) + 1)
        
        let mainView_width = cellSize.width
        let mainView_height = cellSize.height * CGFloat(titleArray.count) + config.trigonHeight
        
        let convertFrame = targetView.convert(targetView.bounds, to: fatherView)
        
        var arrow_x: CGFloat = mainView_width/2.0
        var arrow_y: CGFloat!
        var mainView_x = convertFrame.origin.x + (convertFrame.size.width - mainView_width)/2.0
        if mainView_x < config.horizontalLead {
            arrow_x = max(mainView_width/2.0 - (config.horizontalLead - (convertFrame.origin.x + (convertFrame.size.width - mainView_width)/2.0)), config.strokeWidth/2.0 + config.cornerRadius + config.trigonBottomWidth/2.0)
            mainView_x = config.horizontalLead
        }
        if mainView_x + cellSize.width > fatherView.frame.size.width - config.horizontalLead {
            arrow_x = min(cellSize.width - config.strokeWidth/2.0 - config.cornerRadius - config.trigonBottomWidth/2.0, mainView_width/2.0 + (mainView_x + cellSize.width - fatherView.frame.size.width + config.horizontalLead))
            mainView_x = fatherView.frame.size.width - config.horizontalLead - mainView_width
        }
        
        var mainView_y: CGFloat!
        var content_y: CGFloat!
        switch orientation! {
        case .up:
            mainView_y = convertFrame.origin.y - mainView_height - config.trigonLeading
            content_y = 0
            arrow_y = mainView_height - config.strokeWidth/2.0
            break
        case .bottom:
            mainView_y = convertFrame.origin.y + convertFrame.size.height + config.trigonLeading
            content_y = config.trigonHeight + config.strokeWidth
            arrow_y = config.strokeWidth/2.0
            break
        }
        
        mainView = MWPopoverDrawView(frame: CGRect(x: mainView_x, y: mainView_y, width: mainView_width, height: mainView_height), config: config, orientation: orientation, arrowPoint: CGPoint(x: arrow_x, y: arrow_y))
        self.addSubview(mainView)
        
        
        for i in 0..<titleArray.count {
            let label = getTitleLabel()
            label.frame = CGRect(x: 0, y: content_y, width: cellSize.width, height: cellSize.height)
            label.text = titleArray[i]
            label.tag = i
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction(_:)))
            label.addGestureRecognizer(tap)
            if i != titleArray.count - 1 {
                let lineView = UIView()
                lineView.backgroundColor = config.separatorLineColor
                lineView.frame = CGRect(x: config.separatorLineEdge.left + config.strokeWidth, y: label.frame.size.height - 0.5, width: label.frame.size.width - config.separatorLineEdge.left - config.separatorLineEdge.right - config.strokeWidth * 2, height: 0.5)
                label.addSubview(lineView)
                content_y = content_y + cellSize.height
            }
            mainView.addSubview(label)
        }
    }
    
    @objc private func tapAction(_ tap: UITapGestureRecognizer) {
        if let index = tap.view?.tag {
            self.callBack(index)
            self.removeFromSuperview()
        }
    }
    
    ///获取根控制器
    private static func getCurrentRootVC() -> UIViewController? {
        let currentVC = UIApplication.shared.windows.first?.rootViewController
        return currentVC
    }
    
    private func getTitleLabel() -> UILabel {
        let label = UILabel()
        label.textColor = config.titleColor
        label.font = config.titleFont
        label.backgroundColor = UIColor.clear
        label.textAlignment = .center
        label.isUserInteractionEnabled = true
        return label
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
            self.removeFromSuperview()
        }
    }
}

class MWPopoverDrawView: UIView {
    
    private var orientation: MWPopoverOrientation!
    
    private var config: MWPopoverConfig = MWPopoverConfig()
    
    private var arrowPoint: CGPoint!
    
    init(frame: CGRect, config: MWPopoverConfig? = nil, orientation: MWPopoverOrientation, arrowPoint: CGPoint) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.black.withAlphaComponent(0.0)
        self.orientation = orientation
        self.arrowPoint = arrowPoint
        if config != nil {
            self.config = config!
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
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
