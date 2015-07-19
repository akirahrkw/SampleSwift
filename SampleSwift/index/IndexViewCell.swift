//
//  IndexViewCell.swift
//  SampleSwift
//
//  Created by Akira Hirakawa on 18/7/15.
//  Copyright © 2015 akirahrkw. All rights reserved.
//

import UIKit

class IndexViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!

    var infoButtonHandler: ((info: Information?) -> ())?

    var information: Information?

    @IBAction func infoButtonTapped() {
        infoButtonHandler?(info: information)
    }
}
