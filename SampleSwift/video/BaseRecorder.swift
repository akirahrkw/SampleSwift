//
//  BaseRecorder.swift
//  SampleSwift
//
//  Created by Akira Hirakawa on 28/7/15.
//  Copyright © 2015 akirahrkw. All rights reserved.
//

import UIKit
import AVFoundation

class BaseRecorder: NSObject {

    var captureSession: AVCaptureSession?

    var captureStartRecordingHandler: (() -> ())?

    var captureStopRecordingHandler: ((outputFileURL: NSURL) -> ())?

    override init() {
        super.init()
    }

    func setupCaptureSession(session: AVCaptureSession) {
        captureSession = session
    }

    func addDeviceOutput(output: AVCaptureOutput) -> Bool {

        if captureSession!.canAddOutput(output) {
            captureSession!.addOutput(output)
            return true
        } else {
            print("can't add output: \(output.description)")
            return false
        }
    }

    func createTempFileURL() -> NSURL {
        var path:String = ""
        let fm = NSFileManager.defaultManager()
        var i = 0
        while(path == "" || fm.fileExistsAtPath(path)) {
            path = "\(NSTemporaryDirectory())output-\(i).mov"
            i++
        }
        return NSURL(fileURLWithPath: path)
    }
}
