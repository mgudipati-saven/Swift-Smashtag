//
//  MediaTableViewCell
//  Smashtag
//
//  Created by Murty Gudipati on 3/12/15.
//  Copyright (c) 2015 Murty Gudipati. All rights reserved.
//

import UIKit

class MediaTableViewCell: UITableViewCell
{
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var tweetImage: UIImageView!

    var imageUrl: NSURL? { didSet { updateUI() } }
    
    func updateUI() {
        tweetImage?.image = nil
        if let url = imageUrl {
            spinner?.startAnimating()
            dispatch_async(dispatch_get_global_queue(NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_7_1 ? Int(QOS_CLASS_USER_INITIATED.value) : DISPATCH_QUEUE_PRIORITY_HIGH, 0)) {
                let imageData = NSData(contentsOfURL: url)
                dispatch_async(dispatch_get_main_queue()) {
                    if url == self.imageUrl {
                        if imageData != nil {
                            self.tweetImage?.image = UIImage(data: imageData!)
                        } else {
                            self.tweetImage?.image = nil
                        }
                        self.spinner?.stopAnimating()
                    }
                }
            }
        }
    }
}
