//
//  MentionsTableViewController.swift
//  Smashtag
//
//  Created by Murty Gudipati on 3/10/15.
//  Copyright (c) 2015 Murty Gudipati. All rights reserved.
//

import UIKit

class MentionsTableViewController: UITableViewController
{
    // data model
    var tweet: Tweet? {
        didSet {
            println("\(tweet)")

            if tweet?.media.count > 0 {
                mentions.append(Mention.Image)
            }
            if tweet?.hashtags.count > 0 {
                mentions.append(Mention.Hashtag)
            }
            if tweet?.urls.count > 0 {
                mentions.append(Mention.URL)
            }
            if tweet?.userMentions.count > 0 {
                mentions.append(Mention.User)
            }

            tableView.reloadData()
        }
    }
    
    private enum Mention {
        case Image, Hashtag, URL, User
        
        var title: String {
            switch self {
            case .Image:
                return "Images"
            case .Hashtag:
                return "Hashtags"
            case .URL:
                return "URLs"
            case .User:
                return "Users"
            }
        }
        
        func count(tweet: Tweet) -> Int {
            switch self {
            case .Image:
                return tweet.media.count
            case .Hashtag:
                return tweet.hashtags.count
            case .URL:
                return tweet.urls.count
            case .User:
                return tweet.userMentions.count
            }
        }
        
        func text(tweet: Tweet, index: Int) -> String {
            switch self {
            case .Image:
                return tweet.media.description
            case .Hashtag:
                return tweet.hashtags[index].keyword
            case .URL:
                return tweet.urls[index].keyword
            case .User:
                return tweet.userMentions[index].keyword
            }
        }
    }

    // mentions from the tweet
    private var mentions = [Mention]()

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return mentions.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mentions[section].count(tweet!)
    }

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return mentions[section].title
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Mention", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...
        let mention = mentions[indexPath.section]
        if mention == Mention.Image {
            if let imageURL = tweet?.media[indexPath.row].url {
                if let imageData = NSData(contentsOfURL: imageURL) {
                    cell.imageView?.image = UIImage(data: imageData)
                }
            }
        } else {
            cell.textLabel?.text = mention.text(tweet!, index: indexPath.row)
        }
        
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
