//
//  TweetTableViewCell.swift
//  Smashtag
//
//  Created by Murty Gudipati on 3/8/15.
//  Copyright (c) 2015 Murty Gudipati. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell
{
    var tweet: Tweet? {
        didSet {
            //println("\(tweet)")
            updateUI()
        }
    }
    
    @IBOutlet weak var tweetProfileImageView: UIImageView!
    @IBOutlet weak var tweetScreenNameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    func updateUI() {
        // reset any existing tweet information
        tweetTextLabel?.attributedText = nil
        tweetScreenNameLabel?.text = nil
        tweetProfileImageView?.image = nil
        
        // load new information from our tweet (if any)
        if let tweet = self.tweet {
            tweetTextLabel?.text = tweet.text
            if tweetTextLabel?.text != nil {
                // prepare attributed string for the text label's attributed text
                let attributes = [NSFontAttributeName : UIFont.preferredFontForTextStyle(UIFontTextStyleBody)]
                var attributedString = NSMutableAttributedString(string: tweet.text, attributes: attributes)
                
                // add attributes to hashtags
                for hashtag in tweet.hashtags {
                    attributedString.addAttribute(NSForegroundColorAttributeName, value: HashtagColor, range: hashtag.nsrange)
                }

                // add attributes to urls
                for url in tweet.urls {
                    attributedString.addAttribute(NSForegroundColorAttributeName, value: URLColor, range: url.nsrange)
                }

                // add attributes to user mentions
                for user in tweet.userMentions {
                    attributedString.addAttribute(NSForegroundColorAttributeName, value: UserMentionColor, range: user.nsrange)
                }
                
                tweetTextLabel.attributedText = attributedString
            }
            
            tweetScreenNameLabel?.text = "\(tweet.user)"
            
            if let profileImageURL = tweet.user.profileImageURL {
                if let imageData = NSData(contentsOfURL: profileImageURL) {
                    tweetProfileImageView?.image =  UIImage(data: imageData)
                }
            }
        }
    }
    
    // Constants
    let UserMentionColor = UIColor.purpleColor()
    let HashtagColor = UIColor.brownColor()
    let URLColor = UIColor.blueColor()
}
