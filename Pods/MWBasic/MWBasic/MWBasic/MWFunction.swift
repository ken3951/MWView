//
//  MWFunction.swift
//  MWBasic
//
//  Created by mwk_pro on 2019/4/4.
//  Copyright © 2019 mwk. All rights reserved.
//

import Foundation

//MARK:--tableivew分割线edge
public func mw_tableViewSeparatorEdge(_ left: CGFloat = 40,_ right: CGFloat = 40) -> UIEdgeInsets {
    let tableViewEdge = UIEdgeInsets(top: 0, left: left, bottom: 0, right: right)
    return tableViewEdge
}

//MARK:--自定义print
public func mw_print_d<T>(_ message: T,
                file: String = #file,
                line: Int = #line,
                function:String = #function) {
    
    #if DEBUG || TEST || UAT // 在debug,test,uat环境下打印报错信息
    //stderr
    print("ψ(｀∇´)ψ", String(format:
        """
        
        dddddddddd
        time:\(Date().mw_string("yyyy-MM-dd,HH:mm:ss"))
        file:\((file as NSString).lastPathComponent)
        line:\(line)
        function:\(function)
        message:\(message)
        """))
    #endif
}

public func mw_print_i<T>(_ message: T) {
    
    #if DEBUG || TEST || UAT // 在debug,test,uat环境下打印报错信息
    //stderr
    print("ψ(｀∇´)ψ", String(format:
        """
        
        iiiiiiiiii
        message:\(message)
        """))
    #endif
}

///子线程，主线程皆可使用，等待主线程操作完成
public func mw_mainSynWait(_ execute: @escaping MWCallback) {
    if Thread.isMainThread {
        execute()
    }else{
        let semaphore =  DispatchSemaphore(value: 0)
        DispatchQueue.main.async {
            execute()
            semaphore.signal()
        }
        semaphore.wait()
    }
}

///拼接路径
public func mw_stringPath(_ x: String, _ y: String) -> String {
    return x + "/" + y
}

//MARK:--获取当前时间戳
///获取名字的简称
public func mw_getCurrentTimestamp() -> String {
    let date = NSDate()
    let timestamp = "\(Int(date.timeIntervalSince1970))"
    return timestamp
}

//MARK:--获取根控制器
///获取根控制器
public func mw_getCurrentRootVC() -> UIViewController? {
    let currentVC = UIApplication.shared.windows.first?.rootViewController
    return currentVC
}

///获取名字的简称
public func mw_getSimpleName(name: String?) -> String? {
    if name == nil {
        return nil
    }
    
    if name!.count <= 2 {
        return name
    }
    
    return (name! as NSString).substring(from: name!.count - 2)
}

//MARK:--获取当前正在展示的mainView，UIAlertController除外
///获取当前正在展示的mainView，UIAlertController除外
public func mw_getCurrentMainView() -> UIView? {
    let currentVC = UIApplication.shared.windows.first?.rootViewController
    if let presentedVC = currentVC?.presentedViewController{
        if !presentedVC.isKind(of: UIAlertController.self) {
            return presentedVC.view
        }
    }
    return currentVC?.view
}

//MARK:--获取应用信息
///获取app版本
public func mw_getAppVersion() -> String {
    let infoDictionary = Bundle.main.infoDictionary
    let appVersion = infoDictionary!["CFBundleShortVersionString"] as! String
    return appVersion
}

///获取app版本
public func mw_getAppName() -> String {
    let infoDictionary = Bundle.main.infoDictionary
    let appName = infoDictionary!["CFBundleDisplayName"] as! String
    return appName
}

///获取当前window截图
public func mw_getScreenShotFromWindow() -> UIImage? {
    UIGraphicsBeginImageContextWithOptions(CGSize(width: MW_SCREEN_WIDTH*UIScreen.main.scale, height: MW_SCREEN_HEIGHT*UIScreen.main.scale), true, UIScreen.main.scale)
    
    guard let context = UIGraphicsGetCurrentContext() else {
        return nil
    }
    
    UIApplication.shared.keyWindow?.layer.render(in: context)
    
    let viewImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    guard let imageCG = viewImage?.cgImage else {
        return nil
    }
    
    guard let sendImageCG = imageCG.cropping(to: CGRect(x: 0, y: 0, width: MW_SCREEN_WIDTH*UIScreen.main.scale, height: MW_SCREEN_HEIGHT*UIScreen.main.scale)) else {
        return nil
    }
    
    let sendImage = UIImage(cgImage: sendImageCG)
    return sendImage
    
}

///获取视频截图
public func mw_getScreenShotImageFromLocalVideo(url: URL, seconds: Double = 0.0, completion: @escaping MWImageCallback) {
    DispatchQueue.global().async {
        var shotImage: UIImage?
        let asset = AVURLAsset(url: url, options: nil)
        let gen = AVAssetImageGenerator(asset: asset)
        gen.appliesPreferredTrackTransform = true
        let totalSeconds = mw_getLocalVideoSeconds(url: url)
        let time = CMTimeMakeWithSeconds(seconds, preferredTimescale: Int32(totalSeconds) * 4)
        var actualTime: CMTime = CMTime(value: 0, timescale: 0)
        if let image = try? gen.copyCGImage(at: time, actualTime: &actualTime) {
            shotImage = UIImage(cgImage: image)
        }
        completion(shotImage)
    }
}

///获取视频时长
public func mw_getLocalVideoSeconds(url: URL) -> CGFloat {
    let urlAsset = AVURLAsset(url: url)
    let time = urlAsset.duration
    let seconds = CGFloat(time.value)/CGFloat(time.timescale)
    return seconds
}

///拨打电话
public func mw_callPhone(mobile: String?) {
    if mobile == nil {
        return
    }
    let urlString = "tel://\(mobile!)"
    if let url = URL(string: urlString) {
        //根据iOS系统版本，分别处理
        if #available(iOS 10, *) {
            UIApplication.shared.open(url, options: [:],
                                      completionHandler: {
                                        (success) in
            })
        } else {
            UIApplication.shared.openURL(url)
        }
    }}

///转换视频格式
public func mw_changeVideoFormatWithSourceUrl(sourceUrl: URL, completion: @escaping MWStringCallback) {
    let avAsset = AVURLAsset(url: sourceUrl, options: nil)
    let compatiblePresets = AVAssetExportSession.exportPresets(compatibleWith: avAsset)
    if compatiblePresets.contains(AVAssetExportPresetHighestQuality) {
        let exportSession = AVAssetExportSession(asset: avAsset, presetName: AVAssetExportPresetMediumQuality)
        
        let formater = DateFormatter()
        formater.dateFormat = "yyyy-MM-dd-HH-mm-ss"
        let filePath = "output-\(formater.string(from: Date())).mp4"
        let resultPath = NSHomeDirectory().appending("/Documents/\(filePath)")
        
        exportSession?.outputURL = URL(fileURLWithPath: resultPath)
        
        exportSession?.outputFileType = AVFileType.mp4
        
        exportSession?.shouldOptimizeForNetworkUse = true
        exportSession?.exportAsynchronously(completionHandler: {
            switch (exportSession!.status) {
            case AVAssetExportSession.Status.unknown:
                completion(nil)
                break
            case AVAssetExportSession.Status.waiting:
                completion(nil)
                break
            case AVAssetExportSession.Status.exporting:
                completion(nil)
                break
            case AVAssetExportSession.Status.completed:
                completion(filePath)
                break
            case AVAssetExportSession.Status.failed:
                completion(nil)
                break
            default:
                completion(nil)
                break
            }
        })
    }
}
