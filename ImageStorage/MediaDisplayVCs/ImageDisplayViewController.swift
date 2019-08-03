//
//  MediaDisplayViewController.swift
//  ImageStorage
//
//  Created by Jonathan Hawley on 7/27/19.
//  Copyright © 2019 Jonathan Hawley. All rights reserved.
//

import UIKit

class ImageDisplayViewController: UIViewController {
    var image: UIImage?
    var navBarIsHidden: Bool = false
    
    @IBOutlet weak var displayImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        
        displayImageView.image = image
        displayImageView.isUserInteractionEnabled = true
        displayImageView.addGestureRecognizer(tapGestureRecognizer)
        
        navBarIsHidden = false
        updateUI()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    @objc private func imageTapped(tapGestureRecognizer: UITapGestureRecognizer){
        navBarIsHidden = !navBarIsHidden
        updateUI()
    }
    
    private func updateUI(){
        UIView.animate(withDuration: 0.25) {
            self.view.backgroundColor = self.navBarIsHidden ? UIColor.black : UIColor.white
            self.navigationController?.setNavigationBarHidden(self.navBarIsHidden, animated: true)
        }
    }
}
