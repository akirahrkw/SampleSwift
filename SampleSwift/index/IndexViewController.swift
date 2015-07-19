//
//  ViewController.swift
//  SampleSwift
//
//  Created by Akira Hirakawa on 18/7/15.
//  Copyright © 2015 akirahrkw. All rights reserved.
//

import UIKit

class IndexViewController: UITableViewController {

    let dataSource = TableViewDataSource(identifier: "indexCell")

    override func awakeFromNib() {
        super.awakeFromNib()
        let photo = Information(title:"Photo Samples", identifier:"photoIndex", intro:"Sample Programs for Photos Framework")

        dataSource.items = [photo]
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

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        if let popupSegue = segue as? PopupSegue,
            popupController = popupSegue.destinationViewController as? PopupViewController,
            info = sender as? Information
        {
            popupController.information = info
        }
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        tableView.deselectRowAtIndexPath(indexPath, animated: true)

        if let item = dataSource.itemAtIndexPath(indexPath) as? Information {
            performSegueWithIdentifier(item.identifier, sender: item)
        }
    }
}
