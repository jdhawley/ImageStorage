//
//  MediaDisplayViewController.swift
//  ImageStorage
//
//  Created by Jonathan Hawley on 7/27/19.
//  Copyright © 2019 Jonathan Hawley. All rights reserved.
//

import UIKit

class MediaDisplayViewController: UIViewController {
    var image: UIImage?
    
    @IBOutlet weak var displayImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayImageView.image = image
    }

}
