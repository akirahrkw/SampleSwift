//
//  IPVideoViewController.swift
//  SampleSwift
//
//  Created by Akira Hirakawa on 25/7/15.
//  Copyright © 2015 akirahrkw. All rights reserved.
//

import UIKit
import MobileCoreServices

extension UIImagePickerController {

    class func createImagePicker() -> UIImagePickerController? {

        if isVideoRecordingAvailable() {
            let picker = UIImagePickerController()
            picker.sourceType = .Camera
            picker.mediaTypes = [kUTTypeMovie as String]
            return picker
        }
        return nil
    }

    class func isVideoRecordingAvailable() -> Bool {

        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            if let types = UIImagePickerController.availableMediaTypesForSourceType(.Camera) where types.contains(kUTTypeMovie as String) {
                return true
            }
        }
        return false
    }
    
    func setCameraSetting() {
        sourceType = .Camera
        mediaTypes = [kUTTypeMovie as String]
    }

    func setFrontCamera() {
        if UIImagePickerController.isCameraDeviceAvailable(.Front) {
            cameraDevice = .Front
        }
    }

    func setCustomOverlay(customView: UIView) {
        showsCameraControls = false
        cameraOverlayView = customView
    }
}
