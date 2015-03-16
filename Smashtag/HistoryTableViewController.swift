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
   var items = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        items = SearchHistory.distinct(SearchHistory.items.reverse())
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
        return items.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("History", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...
        cell.textLabel?.text = items[indexPath.row]
        return cell
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
