//
//  ImageCollectionViewController.swift
//  ImageStorage
//
//  Created by Jonathan Hawley on 7/26/19.
//  Copyright © 2019 Jonathan Hawley. All rights reserved.
//

import UIKit
import Photos
import AssetsPickerViewController
import AVKit

private let reuseIdentifier = "imageCell"

class ImageCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
//    var imageNames = [String]()
    var assets = [PHAsset]()
    lazy var imageManager = {
        return PHCachingImageManager()
    }()
    var selectedItem: PHAsset?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        loadImages()
    }

    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return assets.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ImageCollectionViewCell
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let asset = assets[indexPath.item]
        
        let cvCell = cell as! ImageCollectionViewCell
        let imageWidth = cvCell.myImageView.frame.width
        imageManager.requestImage(for: asset, targetSize: CGSize(width: imageWidth, height: imageWidth), contentMode: .aspectFill, options: nil) { (image, info) in
            cvCell.myImageView?.contentMode = .scaleAspectFill
            cvCell.myImageView?.image = image
            cvCell.setNeedsLayout()
            cvCell.layoutIfNeeded()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedItem = assets[indexPath.item]
        switch selectedItem!.mediaType{
        case PHAssetMediaType.image:
            performSegue(withIdentifier: "showImage", sender: self)
        case PHAssetMediaType.video:
            print("Playing a video")
//            performSegue(withIdentifier: "showVideo", sender: self)
//            PHCachingImageManager.requestAVAsset(<#T##self: PHCachingImageManager##PHCachingImageManager#>)
//            let player = AVPlayer(url: asset.URL)
        default:
            fatalError("Unrecognized PHAssetMediaType")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier{
        case "showImage":
            let destination = segue.destination as! ImageDisplayViewController
            let size = view.frame.size
            let image = getImageFromPHAsset(selectedItem!, size: size, deliverMode: .highQualityFormat)
            destination.image = image
        case "showVideo":
            let destination = segue.destination as! VideoDisplayViewController
            destination.asset = selectedItem
        default:
            fatalError("Unknown segue identifier: \(String(describing: segue.identifier))")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let numberOfItemsPerRow:CGFloat = 4
        let spacingBetweenCells:CGFloat = 2
        
        let totalSpacing = (numberOfItemsPerRow - 1) * spacingBetweenCells //Amount of total spacing in a row
        
        if let collection = self.collectionView{
            let width = (collection.bounds.width - totalSpacing)/numberOfItemsPerRow
            return CGSize(width: width, height: width)
        }else{
            return CGSize(width: 0, height: 0)
        }
    }

    @IBAction func addButtonPressed(_ sender: Any) {
        let picker = AssetsPickerViewController()
        picker.pickerDelegate = self
        present(picker, animated: true, completion: nil)
    }
    
    private func getImageFromPHAsset(_ asset: PHAsset, size: CGSize, deliverMode: PHImageRequestOptionsDeliveryMode) -> UIImage?{
        
        var returnImage:UIImage? = nil
        
        let requestImageOption = PHImageRequestOptions()
        requestImageOption.deliveryMode = deliverMode
        requestImageOption.isSynchronous = true
        
        let manager = PHImageManager.default()
        manager.requestImage(for: asset, targetSize:size, contentMode:PHImageContentMode.default, options: requestImageOption) { (image:UIImage?, _) in
            returnImage = image
        }
        
        return returnImage
    }
}

extension ImageCollectionViewController: AssetsPickerViewControllerDelegate {
    
    func assetsPickerCannotAccessPhotoLibrary(controller: AssetsPickerViewController) {
        logw("Need permission to access photo library.")
    }
    
    func assetsPickerDidCancel(controller: AssetsPickerViewController) {
        logi("Cancelled.")
    }
    
    func assetsPicker(controller: AssetsPickerViewController, selected assets: [PHAsset]) {
        self.assets = assets
        collectionView.reloadData()
    }
    
    func assetsPicker(controller: AssetsPickerViewController, shouldSelect asset: PHAsset, at indexPath: IndexPath) -> Bool {
        logi("shouldSelect: \(indexPath.row)")
        
        // can limit selection count
        if controller.selectedAssets.count > 3 {
            // do your job here
        }
        return true
    }
    
    func assetsPicker(controller: AssetsPickerViewController, didSelect asset: PHAsset, at indexPath: IndexPath) {
        logi("didSelect: \(indexPath.row)")
    }
    
    func assetsPicker(controller: AssetsPickerViewController, shouldDeselect asset: PHAsset, at indexPath: IndexPath) -> Bool {
        logi("shouldDeselect: \(indexPath.row)")
        return true
    }
    
    func assetsPicker(controller: AssetsPickerViewController, didDeselect asset: PHAsset, at indexPath: IndexPath) {
        logi("didDeselect: \(indexPath.row)")
    }
    
    func assetsPicker(controller: AssetsPickerViewController, didDismissByCancelling byCancel: Bool) {
        logi("dismiss completed - byCancel: \(byCancel)")
    }
}
