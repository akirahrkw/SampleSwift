//
//  TableViewDataSource.swift
//  SampleSwift
//
//  Created by Akira Hirakawa on 18/7/15.
//  Copyright © 2015 akirahrkw. All rights reserved.
//

import UIKit

typealias CellForRowClosure = (cell:UITableViewCell, indexPath: NSIndexPath, item:Any) -> UITableViewCell!

class TableViewDataSource: NSObject, UITableViewDataSource {

    var items: [Any]

    var cellForRowClosure: CellForRowClosure?

    var identifier: String

    override init(){
        self.items = [Any]()
        self.identifier = "Cell"
    }

    init(identifier: String) {
        self.items = [AnyObject]()
        self.identifier = identifier
    }

    func itemAtIndex(index:Int) -> Any {
        return self.items[index]
    }

    func itemAtIndexPath(indexPath:NSIndexPath) -> Any {
        return self.items[indexPath.row]
    }

    // MARK: - UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as UITableViewCell

        let item = self.itemAtIndexPath(indexPath)
        self.cellForRowClosure?(cell:cell, indexPath:indexPath, item:item)
        return cell
    }
}