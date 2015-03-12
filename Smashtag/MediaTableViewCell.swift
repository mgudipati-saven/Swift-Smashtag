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
    var media: MediaItem? {
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet weak var mediaImageView: UIImageView!
    
    func updateUI() {
        mediaImageView.image = nil
        
        if let media = self.media {
            if let imageURL = media.url {
                let qos = Int(QOS_CLASS_USER_INITIATED.value)
                dispatch_async(dispatch_get_global_queue(qos, 0)) { () -> Void in
                    let imageData = NSData(contentsOfURL: imageURL)
                    dispatch_async(dispatch_get_main_queue()) { () -> Void in
                        if  imageData != nil {
                            self.mediaImageView?.image = UIImage(data: imageData!)
                        }
                    }
                }
            }
        }
    }
}
