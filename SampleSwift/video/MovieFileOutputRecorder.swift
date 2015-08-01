//
//  MovieFileOutputRecorder.swift
//  SampleSwift
//
//  Created by Akira Hirakawa on 28/7/15.
//  Copyright © 2015 akirahrkw. All rights reserved.
//

import UIKit
import AVFoundation

class MovieFileOutputRecorder: BaseRecorder, Recorder {

    var output: AVCaptureMovieFileOutput

    override init() {
        output = AVCaptureMovieFileOutput()
        super.init()
    }

    func addDeviceOutput() -> Bool {
        return super.addDeviceOutput(output)
    }

    func startRecording() {
        createTempFileURL()
        output.startRecordingToOutputFileURL(createTempFileURL(), recordingDelegate: self)
    }

    func stopRecording() {
        output.stopRecording()
    }
}

extension MovieFileOutputRecorder: AVCaptureFileOutputRecordingDelegate {

    func captureOutput(captureOutput: AVCaptureFileOutput!, didStartRecordingToOutputFileAtURL fileURL: NSURL!, fromConnections connections: [AnyObject]!) {

        captureStartRecordingHandler?()
    }

    func captureOutput(captureOutput: AVCaptureFileOutput!, didFinishRecordingToOutputFileAtURL outputFileURL: NSURL!, fromConnections connections: [AnyObject]!, error: NSError!) {

        captureStopRecordingHandler?(outputFileURL:outputFileURL)
    }
}
