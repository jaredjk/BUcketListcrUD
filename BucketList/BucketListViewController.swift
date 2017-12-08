//
//  ViewController.swift
//  BucketList
//
//  Created by Jared K on 11/7/17.
//  Copyright © 2017 Jared K. All rights reserved.
//

import UIKit

// ======== CORE DATA =========
import CoreData
// ======== CORE DATA =========

//protocol TBdelegate: class {
//    func
//}

class BuckeListViewController: UITableViewController {
    
    //COREDATA// use to be -> var items = ["Sleep", "Eat", "Travel", "Run"] but change to ..
    var items = [BucketListItem]()
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext //looking inside application for the managed object context. which is like scratch pad where we can add, change and delete our items and save into database.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllItems() //CORE DATA // Load data
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // how many rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    // how each cell looks like
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListItemCell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row].text!
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItemSegue" {
            let navigationController = segue.destination as! UINavigationController
            let addItemTableViewController = navigationController.topViewController as! AddItemTableViewController
            addItemTableViewController.delegate = self as! AddItemTableViewControllerDelegate
        } else if segue.identifier == "EditItemSegue" {
            let navigationController = segue.destination as! UINavigationController
            let addItemTableViewController = navigationController.topViewController as! AddItemTableViewController
            addItemTableViewController.delegate = self as! AddItemTableViewControllerDelegate
            
            let indexPath = sender as! NSIndexPath
            let item = items[indexPath.row]
            addItemTableViewController.item = item.text!
            addItemTableViewController.indexPath = indexPath
            
            
        }
        
    }
    
// ======== CORE DATA =========
    func fetchAllItems() {

        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "BucketListItem")
        
        // Use my managed object context to fetch the request, use "try" with "do" and catch any errors
        do {
            let result = try managedObjectContext.fetch(request)
            
            // let result as BucketListItem. replacing the "items" previously set.
            items = result as! [BucketListItem]
        } catch {
            print("\(error)")
        }
    }
// ======== CORE DATA =========
    
    func cancelButtonPressed(by controller: AddItemTableViewController) {
//        print("I'm the hidden controller, BUT I am responding to the cancel button press on the top view controller.")
        dismiss(animated: true, completion: nil)
    }
    
// ===== CORE DATA ==== send back to main controller after save is pressed
    func itemSaved(by controller: AddItemTableViewController, with text: String, at indexPath: NSIndexPath?) {
        if let ip = indexPath {

            let item = items[ip.row]
            item.text = text

        } else {

            let item = NSEntityDescription.insertNewObject(forEntityName: "BucketListItem", into: managedObjectContext) as! BucketListItem
            item.text = text
            items.append(item)

        }

        do {
            try managedObjectContext.save()
        } catch {
            print("\(error)")
        }

        tableView.reloadData()
        dismiss(animated: true, completion: nil)

    }
}

