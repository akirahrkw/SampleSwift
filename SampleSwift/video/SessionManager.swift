//
//  SessionManager.swift
//  SampleSwift
//
//  Created by Akira Hirakawa on 1/8/15.
//  Copyright © 2015 akirahrkw. All rights reserved.
//

import UIKit
import AVFoundation

class SessionManager: NSObject {

    var sessionQueue = dispatch_queue_create("com.akirahrkw.sampleswift", DISPATCH_QUEUE_SERIAL)

    var captureSession = AVCaptureSession()

    var recorder: Recorder

    var previewLayer: AVCaptureVideoPreviewLayer

    var isRecording = false

    init(recorder aRecorder: Recorder) {
        recorder = aRecorder
        recorder.setupCaptureSession(captureSession)
        recorder.addDeviceOutput()
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
    }

    func configure() {
        addDeviceInput(AVMediaTypeVideo)
        addDeviceInput(AVMediaTypeAudio)
    }

    func showAvailableDevices() {
        let devices = AVCaptureDevice.devices()
        for device in devices {
            print(device)
        }
    }

    func startRunning() {
        dispatch_sync(sessionQueue) { [unowned self] in
            self.captureSession.startRunning()
        }
    }

    func stopRunning() {
        dispatch_sync(sessionQueue) { [unowned self] in
            self.stopRecording()
            self.captureSession.stopRunning()
        }
    }

    func startRecording() {
        isRecording = true
        recorder.startRecording()
    }

    func stopRecording() {
        isRecording = false
        recorder.stopRecording()
    }

    private func addDeviceInput(mediaType: String) -> Bool {

        do {
            let device = AVCaptureDevice.defaultDeviceWithMediaType(mediaType)
            let input = try AVCaptureDeviceInput(device: device)

            if captureSession.canAddInput(input) {
                captureSession.addInput(input)
                return true
            } else {
                print("can't add input: \(input.description)")
                return false
            }

        } catch {
            print(error)
            return false
        }
    }
}
