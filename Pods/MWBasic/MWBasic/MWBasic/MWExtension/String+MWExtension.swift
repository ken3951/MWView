//
//  String+Extension.swift
//  Swift_UIView
//
//  Created by mwk_pro on 2017/2/21.
//  Copyright © 2017年 mwk_pro. All rights reserved.
//

import Foundation

public extension String {
    var mw_sequences: Array<String> {
        var arr: Array<String> = []
        enumerateSubstrings(in: startIndex..<endIndex, options: String.EnumerationOptions.byComposedCharacterSequences) { (str, range1, range2, _) in
            if let subStr = str {
                arr.append(subStr)
            }
        }
        return arr
    }
    
    subscript(index: Int) -> Character {
        let position = self.index(self.startIndex, offsetBy: index)
        return self[position]
    }
    
    subscript(index: Int) -> String {
        return String(self[index] as Character)
    }
    
    subscript(range: Range<Int>) -> String {
        let start = self.index(self.startIndex, offsetBy: range.lowerBound)
        let end = self.index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start..<end])
    }
    
    ///根据左右字符串获取中间的string，并不包含左右字符串
    func mw_getCenterStringNotContain(leftStr:String, rightStr:String) -> String? {
        let totalStr = self as NSString
        var startIndex = 0
        var endIndex = 0
        let startRange = totalStr.range(of: leftStr)
        let endRange = totalStr.range(of: rightStr)
        if startRange.length > 0 && endRange.length > 0 {
            startIndex = startRange.location + startRange.length
            endIndex = endRange.location
            let subStr = totalStr.substring(with: NSRange.init(location: startIndex, length: endIndex-startIndex))
            return subStr
        }
        return nil
    }
    
    ///根据左右字符串获取中间的string，并包含左右字符串
    func mw_getCenterStringContain(leftStr:String, rightStr:String) -> String? {
        let totalStr = self as NSString
        var startIndex = 0
        var endIndex = 0
        let startRange = totalStr.range(of: leftStr)
        let endRange = totalStr.range(of: rightStr)
        if startRange.length > 0 && endRange.length > 0 {
            startIndex = startRange.location
            endIndex = endRange.location  + endRange.length
            let subStr = totalStr.substring(with: NSRange.init(location: startIndex, length: endIndex-startIndex))
            return subStr
        }
        return nil
    }
    
    func mw_stringPath(_ x:String) -> String {
        return self.appending("/\(x)")
    }
    
    ///判断是否是手机号
    func mw_isMobile() -> Bool {
        //检测是否是手机号
        let predicateStr = "^1\\d{10}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@",predicateStr)
        let result = predicate.evaluate(with: self)
        return result
    }
    
    ///判断两位小数
    func mw_isFloat2() -> Bool {
        //是两位小数
        let predicateStr = "^\\-?([1-9]\\d*|0)(\\.\\d{0,2})?$"
        let predicate = NSPredicate(format: "SELF MATCHES %@",predicateStr)
        let result = predicate.evaluate(with: self)
        return result
    }
    
    //时间戳转string
    func mw_date(format:String) -> String {
        let str = self as NSString
        
        let interval = (str.substring(to: 10) as NSString).doubleValue
        let date = Date.init(timeIntervalSince1970: interval)
        let formatter = DateFormatter.init()
        formatter.dateFormat=format
        return formatter.string(from: date)
    }
    
    ///创建QRImage
    func mw_createQRImage(scale:CGFloat) -> UIImage {
        let filter = CIFilter.init(name: "CIQRCodeGenerator")
        filter?.setDefaults()
        let data = self.data(using: String.Encoding.utf8)
        filter?.setValue(data, forKey: "inputMessage")
        filter?.setValue("H", forKey: "inputCorrectionLevel")

        return UIImage(ciImage: filter!.outputImage!
            .transformed(by: CGAffineTransform(scaleX: scale, y: scale)))
    }
    
    ///string转字典
    func mw_toDictionary() -> [String: Any]? {
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                mw_print_d(error.localizedDescription)
            }
        }
        return nil
    }
    
    ///string转数组
    func mw_toArray() -> Array<Any>? {
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? Array<Any>
            } catch {
                mw_print_d(error.localizedDescription)
            }
        }
        return nil
    }
    
    ///去掉小数点后面的0
    func mw_deleteInvalidZero() -> String {
        var outNumber = self
        var i = 0
        
        if self.contains("."){
            while i < self.count{
                if outNumber.hasSuffix("0"){
                    outNumber.removeLast()
                    i = i + 1
                }else{
                    break
                }
            }
            if outNumber.hasSuffix("."){
                outNumber.removeLast()
            }
            return outNumber
        }
        else{
            return outNumber
        }
    }
    
    ///HTMLString转化为NSAttributedString
    func mw_htmlStringToAttributedString(textSize: CGFloat = 22.0) -> NSAttributedString? {
        let headerS = "<html lang=\"zh-cn\"><head><meta charset=\"utf-8\"><meta name=\"viewport\" content=\"width=device-width, nickName-scalable=no\"></meta><style>img{max-width: 100%; width:auto; height:auto;}body{color:#333;text-align:justify;font-size:\(textSize)px !important;}</style></head><body>"
        let endS = "</body></html>"
        let string = headerS + self + endS

        let attStr = try? NSMutableAttributedString(data: string.data(using: String.Encoding.utf8)!, options: [NSAttributedString.DocumentReadingOptionKey.documentType : NSAttributedString.DocumentType.html], documentAttributes: nil)
        return attStr
    }

    ///获取文件大小方法
    func mw_getFileSize() -> UInt64  {
        var size: UInt64 = 0
        let fileManager = FileManager.default
        var isDir: ObjCBool = false
        let isExists = fileManager.fileExists(atPath: self, isDirectory: &isDir)
        // 判断文件存在
        if isExists {
            // 是否为文件夹
            if isDir.boolValue {
                // 迭代器 存放文件夹下的所有文件名
                let enumerator = fileManager.enumerator(atPath: self)
                for subPath in enumerator! {
                    // 获得全路径
                    let fullPath = self.appending("/\(subPath)")
                    do {
                        let attr = try fileManager.attributesOfItem(atPath: fullPath)
                        size += attr[FileAttributeKey.size] as! UInt64
                    } catch  {
                        print("error :\(error)")
                    }
                }
            } else {    // 单文件
                do {
                    let attr = try fileManager.attributesOfItem(atPath: self)
                    size += attr[FileAttributeKey.size] as! UInt64
                    
                } catch  {
                    print("error :\(error)")
                }
            }
        }
        return size
    }
}

