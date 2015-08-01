//
//  Recorder.swift
//  SampleSwift
//
//  Created by Akira Hirakawa on 28/7/15.
//  Copyright © 2015 akirahrkw. All rights reserved.
//

import UIKit
import AVFoundation

protocol Recorder {

    func setupCaptureSession(session: AVCaptureSession)

    func addDeviceOutput() -> Bool

    func startRecording()

    func stopRecording()
}
