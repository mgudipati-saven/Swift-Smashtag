//
//  HistoryTableViewController.swift
//  Smashtag
//
//  Created by Murty Gudipati on 3/14/15.
//  Copyright (c) 2015 Murty Gudipati. All rights reserved.
//

import UIKit

class HistoryTableViewController: UITableViewController {

    private let defaults = NSUserDefaults.standardUserDefaults()
    
    var searchHistory: [String] {
        get { return defaults.objectForKey("TwitterSearch.History") as? [String] ?? [] }
        set { defaults.setObject(newValue, forKey: "TwitterSearch.History") }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchHistory.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("History", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...
        cell.textLabel?.text = searchHistory[indexPath.row]
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
