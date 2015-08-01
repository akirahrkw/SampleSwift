//
//  ViewController.swift
//  SampleSwift
//
//  Created by Akira Hirakawa on 18/7/15.
//  Copyright © 2015 akirahrkw. All rights reserved.
//

import UIKit
import Photos

class IndexViewController: UITableViewController {

    let dataSource = TableViewDataSource(identifier: "indexCell")

    override func awakeFromNib() {
        super.awakeFromNib()
        let photo = Information(title:"Photo Samples", identifier:"photoIndex", intro:"Sample Programs for Photos Framework")
        let ipVideo = Information(title:"Video by Image Picker Samples", identifier:"imagePickerVideo", intro:"Sample Programs for Image Picker")
        let avfoundation = Information(title:"Video by AVFoundation", identifier:"avFoundationVideo", intro:"Sample Programs for AVFoundation")

        dataSource.items = [photo, ipVideo, avfoundation]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = dataSource

        let infoButtonHandler = { [unowned self] (info: Information?) -> () in
            if let aInfo = info {
                self.performSegueWithIdentifier("infoPopup", sender: aInfo)
            }
        }

        dataSource.cellForRowClosure = { (cell: UITableViewCell, indexPath: NSIndexPath, item:Any) -> UITableViewCell! in

            if let indexCell = cell as? IndexViewCell, info = item as? Information {
                indexCell.titleLabel.text = info.title
                indexCell.infoButtonHandler = infoButtonHandler
                indexCell.information = info
            }
            return cell
        }
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        tableView.deselectRowAtIndexPath(indexPath, animated: true)

        if let item = dataSource.itemAtIndexPath(indexPath) as? Information {

            if item.identifier == "imagePickerVideo" &&
                !UIImagePickerController.isVideoRecordingAvailable() {
                return
            }

            performSegueWithIdentifier(item.identifier, sender: item)
        }
    }
}

extension IndexViewController {

    // this is not called when u call performSegue
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {

        if identifier == "imagePickerVideo" {
            return UIImagePickerController.isVideoRecordingAvailable()
        }
        return super.shouldPerformSegueWithIdentifier(identifier, sender: sender)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        if let popupSegue = segue as? PopupSegue,
            popupController = popupSegue.destinationViewController as? PopupViewController,
            info = sender as? Information
        {
            popupController.information = info
        }

        if segue.identifier == "imagePickerVideo" {
            if let imagePicker = segue.destinationViewController as? UIImagePickerController {
                imagePicker.setCameraSetting()
                imagePicker.delegate = self
            }
        }
    }
}

extension IndexViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {

        if let fileURL = info[UIImagePickerControllerMediaURL] as? NSURL {
            let library = PHPhotoLibrary.sharedPhotoLibrary()
            library.performChanges({
                PHAssetChangeRequest.creationRequestForAssetFromVideoAtFileURL(fileURL)
            }, completionHandler: {(result: Bool, error: NSError?) -> () in
                print("video file was saved")
            })
        }
        picker.dismissViewControllerAnimated(true, completion: nil)
    }

    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
}