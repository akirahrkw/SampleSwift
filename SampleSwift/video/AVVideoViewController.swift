//
//  AVVideoViewController.swift
//  SampleSwift
//
//  Created by Akira Hirakawa on 28/7/15.
//  Copyright © 2015 akirahrkw. All rights reserved.
//

import UIKit
import AVFoundation
import AssetsLibrary
import Photos

/// http://www.objc.io/issues/23-video/capturing-video/
class AVVideoViewController: UIViewController {

    @IBOutlet weak var recordButton: UIBarButtonItem!
    
    var granted = true

    var manager: SessionManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        checkPermissions()

        if granted {
            configure()
        }
    }

    func checkPermissions() {
        showAlertView(AVMediaTypeAudio, title: "Microphone Disabled")
        showAlertView(AVMediaTypeVideo, title: "Video Disabled")
    }

    func configure() {
        let recorder = MovieFileOutputRecorder()
        recorder.captureStartRecordingHandler = {[unowned self] in
            print("capture started")
            self.recordButton.title = "Stop"
        }
        recorder.captureStopRecordingHandler = { [unowned self] (outputFileURL: NSURL) -> () in
            print("capture stopped")
            self.saveFile(outputFileURL)
            self.recordButton.title = "Record"
        }

        manager = SessionManager(recorder: recorder)
        manager.configure()
        manager.previewLayer.frame = view.frame
        view.layer.insertSublayer(manager.previewLayer, atIndex: 0)
        manager.startRunning()

        // Debug
        manager.showAvailableDevices()
    }

    @IBAction func start() {
        if manager.isRecording {
            manager.stopRecording()
        } else {
            manager.startRecording()
        }
    }

    @IBAction func close() {
        manager.stopRunning()
        dismissViewControllerAnimated(true, completion: nil)
    }

    func saveFile(fileURL: NSURL) {
        let library = PHPhotoLibrary.sharedPhotoLibrary()
        library.performChanges({
            PHAssetChangeRequest.creationRequestForAssetFromVideoAtFileURL(fileURL)
        }, completionHandler: {(result: Bool, error: NSError?) -> () in
            print("video file was saved")
        })
    }
    
    private func showAlertView(mediaType: String, title: String) {

        AVCaptureDevice.requestAccessForMediaType(mediaType, completionHandler:{ [unowned self] (granted: Bool) -> () in

            if !granted {
                self.granted = false
                dispatch_async(dispatch_get_main_queue(), {

                    let alert = UIAlertController(title: title, message: "Go to Settings Page", preferredStyle: .Alert)
                    let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
                    alert.addAction(cancelAction)

                    let handler = { (action: UIAlertAction) -> () in
                        UIApplication.sharedApplication().openURL(NSURL(string: UIApplicationOpenSettingsURLString)!)
                    }
                    alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: handler))
                    self.presentViewController(alert, animated: true, completion: nil)
                })
            }
        })
    }
}
