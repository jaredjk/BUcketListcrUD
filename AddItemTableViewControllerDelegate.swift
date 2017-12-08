//
//  AddItemTableViewControllerDelegate.swift
//  BucketList
//
//  Created by Jared K on 11/7/17.
//  Copyright © 2017 Jared K. All rights reserved.
//

import Foundation

protocol AddItemTableViewControllerDelegate: class {
    
    func itemSaved(by controller: AddItemTableViewController, with text: String, at indexPath: NSIndexPath)
    func cancelButtonPressed(by controller: AddItemTableViewController)
    
}
