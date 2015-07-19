//
//  PopupViewController.swift
//  SampleSwift
//
//  Created by Akira Hirakawa on 20/7/15.
//  Copyright © 2015 akirahrkw. All rights reserved.
//

import UIKit

class PopupViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!

    var information: Information!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layoutMargins = UIEdgeInsetsZero

        let l = self.view.layer
        let color = UIColor(red:239.0/255.0, green:81.0/255.0, blue:123.0/255.0, alpha:1.0)
        l.borderColor = color.CGColor
        l.borderWidth = 1.0

        textView.text = information.intro
        textView.textAlignment = NSTextAlignment.Center
    }

    @IBAction func close() {
        willMoveToParentViewController(nil)
        removeFromParentViewController()
        view.removeFromSuperview()
    }
}
