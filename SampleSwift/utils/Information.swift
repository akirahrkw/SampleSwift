//
//  Infomation.swift
//  SampleSwift
//
//  Created by Akira Hirakawa on 18/7/15.
//  Copyright © 2015 akirahrkw. All rights reserved.
//

import UIKit

class Information: NSObject {

    var title: String

    var identifier: String

    var intro: String

    init(title aTitle:String, identifier aIdentifier:String, intro aIntro:String) {
        title = aTitle
        identifier = aIdentifier
        intro = aIntro
    }
}
