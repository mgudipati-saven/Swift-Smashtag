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
            mediaImage = nil
            updateUI()
        }
    }
    
    private var mediaImage: UIImage? {
        get {
            return mediaImageView.image
        }
        set {
            mediaImageView.image = newValue
            mediaImageView.sizeToFit()
            spinner.stopAnimating()
        }
    }
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBOutlet weak var mediaImageView: UIImageView!
    
    func updateUI() {
        if let media = self.media {
            if let imageURL = media.url {
                spinner.startAnimating()
                let qos = Int(QOS_CLASS_USER_INITIATED.value)
                dispatch_async(dispatch_get_global_queue(qos, 0)) { () -> Void in
                    let imageData = NSData(contentsOfURL: imageURL)
                    dispatch_async(dispatch_get_main_queue()) { () -> Void in
                        if  imageData != nil {
                            self.mediaImage = UIImage(data: imageData!)
                        } else {
                            self.mediaImage = nil
                        }
                    }
                }
            }
        }
    }
}
