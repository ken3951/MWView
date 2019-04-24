//
//  CameraManager.swift
//  WorkPlatformIOS
//
//  Created by mwk_pro on 2019/3/19.
//  Copyright © 2019 mwk_pro. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import MobileCoreServices

public typealias MWCameraManagerImageCallBack = (_ img: UIImage) -> Void
public typealias MWCameraManagerVideoCallBack = (_ videoUrl: URL) -> Void

public class MWCameraManager: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    ///视频录制最大秒数
    private var videoMaxTime = 20
    
    ///视频录制最少秒数
    private var videoMinTime = 0
    
    ///单位kb
    private var imageCompressSize = 1000
    
    private var imgCallBack: MWCameraManagerImageCallBack?
    
    private var videoCallBack: MWCameraManagerVideoCallBack?
    
    ///检测权限
    private func checkPermissionSuccess() -> Bool {
        let authStatus = AVCaptureDevice.authorizationStatus(for: .video)
        if authStatus == AVAuthorizationStatus.restricted ||
            authStatus == AVAuthorizationStatus.denied {
            ///没有权限
            mw_showAlert(message: "请打开[设置] - [隐私] - [相机] - [\(mw_getAppName())]权限", buttonItems: ["设置","好"]) { (index) in
                if index == 0 {
                    let url = URL(string: UIApplication.openSettingsURLString)!
                    if UIApplication.shared.canOpenURL(url){
                        UIApplication.shared.openURL(url)
                    }
                }
            }
            return false
        }
        if !UIImagePickerController
            .isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            mw_showAlert(message: "手机不支持拍摄")
            return false
        }
        return true
    }
    
    ///拍照
    @objc public func startRecordPhoto(imageCompressSize: Int = 1000, completion: @escaping MWCameraManagerImageCallBack) {
        
        if checkPermissionSuccess() {
            self.imgCallBack = completion
            self.imageCompressSize = imageCompressSize
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = UIImagePickerController.SourceType.camera
            mw_getCurrentRootVC()?.present(picker, animated: true, completion: nil)
        }

    }
    
    ///录制视频
    @objc public func startRecordVideo(maxTime: Int = 20, minTime: Int = 0, completion: @escaping MWCameraManagerVideoCallBack) {
        
        if checkPermissionSuccess() {
            self.videoCallBack = completion
            self.videoMaxTime = maxTime
            self.videoMinTime = minTime
            
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.videoQuality = .typeIFrame1280x720
            picker.sourceType = UIImagePickerController.SourceType.camera
            picker.videoMaximumDuration = TimeInterval(videoMaxTime)
            picker.mediaTypes = [kUTTypeMovie] as [String]
            mw_getCurrentRootVC()?.present(picker, animated: true, completion: nil)
        }
        
    }
    
    //MARK:--UIImagePickerControllerDelegate
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if picker.sourceType == UIImagePickerController.SourceType.camera {
            if let mediaTypes = picker.mediaTypes.last {
                if mediaTypes == kUTTypeMovie as String {
                    let videoUrl = info[UIImagePickerController.InfoKey.mediaURL] as! URL
                    let duration = mw_getLocalVideoSeconds(url: videoUrl)
                    if duration >= CGFloat(videoMinTime) {
                        self.videoCallBack?(videoUrl)
                    }
                    picker.dismiss(animated: true) {
                        if duration < CGFloat(self.videoMinTime) {
                            mw_showAlert(message: "视频长度应大于\(self.videoMinTime)秒")
                        }
                    }
                    return
                }
            }
            if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                let image = originalImage.mw_scalTo(kb: imageCompressSize)
                self.imgCallBack?(image)
                picker.dismiss(animated: true, completion: nil)
                return
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }
}
