//
//  PhotoIndexViewController.swift
//  SampleSwift
//
//  Created by Akira Hirakawa on 18/7/15.
//  Copyright © 2015 akirahrkw. All rights reserved.
//

import UIKit
import Photos

/// load photo albums
class PhotoIndexViewController: UITableViewController {

    var collections: [PHFetchResult] = []

    let titles: [String] = ["Smart Albums", "Albums"]

    override func awakeFromNib() {
        let smartAlbums = PHAssetCollection.fetchAssetCollectionsWithType(.SmartAlbum, subtype: .AlbumRegular, options: nil)
        let albums = PHCollectionList.fetchTopLevelUserCollectionsWithOptions(nil)
        collections = [smartAlbums, albums]
        PHPhotoLibrary.sharedPhotoLibrary().registerChangeObserver(self)
    }

    deinit {
        PHPhotoLibrary.sharedPhotoLibrary().unregisterChangeObserver(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //TODO
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    }

    @IBAction func addAlbum() {
        let alert = UIAlertController(title: "New Album", message: nil, preferredStyle:.Alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler:nil)
        alert.addAction(cancelAction)
        alert.addTextFieldWithConfigurationHandler({ (textField: UITextField) in
            textField.placeholder = "Album Name"
        })

        let createHandler = { (action: UIAlertAction) -> () in
            let field = alert.textFields?.first
            let title = field?.text
            let library = PHPhotoLibrary.sharedPhotoLibrary()

            library.performChanges({
                PHAssetCollectionChangeRequest.creationRequestForAssetCollectionWithTitle(title!)
                }, completionHandler:{ (success:Bool, error:NSError?) -> () in
                    if !success {
                        print("Error creating album: \(error)")
                    }
            })
        }

        alert.addAction(UIAlertAction(title: "Create", style: .Default, handler: createHandler))
        presentViewController(alert, animated: true, completion: nil)
    }
}

// tableview datasource
extension PhotoIndexViewController {

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1 + collections.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if section == 0 {
            return 1
        } else {
            return collections[section-1].count
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier("photoIndexCell", forIndexPath: indexPath) as! PhotoIndexCell

        if indexPath.section == 0 {
            cell.titleLabel.text = "All Photos"
        } else {
            let fetchResult = collections[indexPath.section - 1]
            let collection = fetchResult[indexPath.row]
            cell.titleLabel.text = collection.localizedTitle
        }

        return cell
    }

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section > 0 {
            return titles[section - 1]
        } else {
            return nil
        }
    }
}

extension PhotoIndexViewController: PHPhotoLibraryChangeObserver {

    func photoLibraryDidChange(changeInstance: PHChange) {

        dispatch_async(dispatch_get_main_queue(), { [unowned self] in
            let changeDetail = changeInstance.changeDetailsForFetchResult(self.collections[1])

            if let changes = changeDetail?.fetchResultAfterChanges {
                self.collections[1] = changes
                self.tableView.reloadData()
            }
        })
    }
}