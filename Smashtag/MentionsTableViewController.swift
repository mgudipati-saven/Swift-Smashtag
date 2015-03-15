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
            //println("\(tweet)")

            if let media = tweet?.media {
                if media.count > 0 {
                    mentions.append(Mention.Image(media))
                }
            }
            
            if let hashtags = tweet?.hashtags {
                if hashtags.count > 0 {
                    mentions.append(Mention.Hashtag(hashtags))
                }
            }

            if let urls = tweet?.urls {
                if urls.count > 0 {
                    mentions.append(Mention.URL(urls))
                }
            }
            
            if let userMentions = tweet?.userMentions {
                if userMentions.count > 0 {
                    mentions.append(Mention.User(userMentions))
                }
            }

            tableView.reloadData()
        }
    }
    
    private enum Mention {
        case Image([MediaItem])
        case Hashtag([Tweet.IndexedKeyword])
        case URL([Tweet.IndexedKeyword])
        case User([Tweet.IndexedKeyword])
        
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
        
        func count() -> Int {
            switch self {
            case .Image(let media):
                return media.count
            case .Hashtag(let hashtags):
                return hashtags.count
            case .URL(let urls):
                return urls.count
            case .User(let userMentions):
                return userMentions.count
            }
        }
        
        func text(index: Int) -> String {
            switch self {
            case .Image(let media):
                return media[index].description
            case .Hashtag(let hashtags):
                return hashtags[index].keyword
            case .URL(let urls):
                return urls[index].keyword
            case .User(let userMentions):
                return userMentions[index].keyword
            }
        }
    }

    // mentions from the tweet
    private var mentions = [Mention]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = tableView.rowHeight
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
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
        return mentions[section].count()
    }

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return mentions[section].title
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Configure the cell...
        let mention = mentions[indexPath.section]
        switch mention {
        case .Image(let media):
            let cell = tableView.dequeueReusableCellWithIdentifier("ImageMention", forIndexPath: indexPath) as MediaTableViewCell

            cell.media = media[indexPath.row]
            return cell
            
        case .URL(let url):
            let cell = tableView.dequeueReusableCellWithIdentifier("URLMention", forIndexPath: indexPath) as UITableViewCell
            
            cell.textLabel?.text = url[indexPath.row].keyword
            return cell
            
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("TextMention", forIndexPath: indexPath) as UITableViewCell
            cell.textLabel?.text = mention.text(indexPath.row)
            return cell
        }
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let mention = mentions[indexPath.section]
        switch mention {
        case .Image(let media):
            let aspectRatio = media[indexPath.row].aspectRatio
            return tableView.contentSize.width / CGFloat(aspectRatio)
        default:
            return UITableViewAutomaticDimension
        }
    }
    
    // MARK: - Navigation
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let mention = mentions[indexPath.section]
        switch mention {
        case .URL(let url):
            UIApplication.sharedApplication().openURL(NSURL(string: url[indexPath.row].keyword)!)
        default:
            return
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destination = segue.destinationViewController as UIViewController
        if let nc = destination as? UINavigationController {
            destination = nc.visibleViewController
        }
        if let ivc = destination as? ImageViewController {
            if let cell = sender as? MediaTableViewCell {
                ivc.imageURL = cell.media?.url
            }
        } else if let tvc = destination as? TweetTableViewController {
            if let cell = sender as? UITableViewCell {
                tvc.searchText = cell.textLabel?.text
            }
        }
    }
}
