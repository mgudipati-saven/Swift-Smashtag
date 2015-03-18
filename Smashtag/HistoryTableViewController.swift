//
//  HistoryTableViewController.swift
//  Smashtag
//
//  Created by Murty Gudipati on 3/14/15.
//  Copyright (c) 2015 Murty Gudipati. All rights reserved.
//

import UIKit

class HistoryTableViewController: UITableViewController
{
    var searchTerms: [String] {
        get { return SearchHistory.terms }
        set { SearchHistory.terms = newValue }
    }
    
    var items = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchTerms.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("History", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...
        cell.textLabel?.text = searchTerms[indexPath.row]
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            searchTerms.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destination = segue.destinationViewController as UIViewController
        if let nc = destination as? UINavigationController {
            destination = nc.visibleViewController
        }
        if let tvc = destination as? TweetTableViewController {
            if let cell = sender as? UITableViewCell {
                tvc.searchText = cell.textLabel?.text
            }
        }
    }
}
