//
//  PopupSegue.swift
//  SampleSwift
//
//  Created by Akira Hirakawa on 19/7/15.
//  Copyright © 2015 akirahrkw. All rights reserved.
//

import UIKit

class PopupSegue: UIStoryboardSegue {

    override func perform() {

        sourceViewController.addChildViewController(destinationViewController)
        sourceViewController.view.addSubview(destinationViewController.view)

        let srcRect = sourceViewController.view.frame
        var destRect = destinationViewController.view.frame
        let posX = (CGRectGetWidth(srcRect) - CGRectGetWidth(destRect)) / 2
        let posY = (CGRectGetHeight(srcRect) - CGRectGetHeight(destRect)) / 2

        destRect.origin = CGPointMake(posX, posY)

        destinationViewController.view.frame = destRect
        destinationViewController.didMoveToParentViewController(sourceViewController)
    }
}
