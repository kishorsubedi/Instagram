//
//  photosCell.swift
//  Instagram
//
//  Created by Kishor Subedi on 3/3/18.
//  Copyright © 2018 Kishor Subedi. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class photosCell: UITableViewCell {

    @IBOutlet weak var postedimageView: PFImageView!
    
    var instagramPost: PFObject! {
        didSet {
            self.postedimageView.file = instagramPost["image"] as? PFFile
            self.postedimageView.loadInBackground()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
