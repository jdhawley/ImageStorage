//
//  FolderTableViewCell.swift
//  ImageStorage
//
//  Created by Jonathan Hawley on 7/26/19.
//  Copyright © 2019 Jonathan Hawley. All rights reserved.
//

import UIKit

class FolderTableViewCell: UITableViewCell {
    
    // MARK: Properties
    @IBOutlet weak var folderLabel: UILabel!
    @IBOutlet weak var folderImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
