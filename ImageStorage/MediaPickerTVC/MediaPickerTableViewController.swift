//
//  MediaPickerTableViewController.swift
//  ImageStorage
//
//  Created by Jonathan Hawley on 7/27/19.
//  Copyright © 2019 Jonathan Hawley. All rights reserved.
//

import UIKit
import Photos
import AssetsPickerViewController

class MediaPickerTableViewController: UITableViewController {
    
    let kCellReuseIdentifier: String = UUID().uuidString
    lazy var imageManager = {
        return PHCachingImageManager()
    }()
    lazy var cellSize: CGSize = {
        return CGSize(width: self.view.bounds.width, height: 60)
    }()
    var assets = [PHAsset]()
    
    override func viewDidLoad() {
//        super.viewDidLoad()
//        tableView.dataSource = self
//        tableView.delegate = self
//        tableView.rowHeight = cellSize.height
    }
    
    // MARK: - Delegates
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return assets.count
//    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: kCellReuseIdentifier) else {
            return UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: kCellReuseIdentifier)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let asset = assets[indexPath.row]
        
        // set title & summary
        cell.textLabel?.text = "[\(asset.mediaType == .image ? "Photo" : "Video")] \(asset.pixelWidth)x\(asset.pixelHeight)"
        cell.detailTextLabel?.text = "\(asset.creationDate?.description ?? "Unknown")"
        
        // set image
        let imageWidth = cellSize.height * UIScreen.main.scale
        imageManager.requestImage(for: asset, targetSize: CGSize(width: imageWidth, height: imageWidth), contentMode: .aspectFill, options: nil) { (image, info) in
            cell.imageView?.contentMode = .scaleAspectFill
            cell.imageView?.image = image
            cell.setNeedsLayout()
            cell.layoutIfNeeded()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
        //segue to detail view here
    }
    
//    @IBAction func addButtonPressed(_ sender: Any) {
//        let picker = AssetsPickerViewController()
//        picker.pickerDelegate = self
//        present(picker, animated: true, completion: nil)
//    }
}

//extension MediaPickerTableViewController: AssetsPickerViewControllerDelegate {
//
//    func assetsPickerCannotAccessPhotoLibrary(controller: AssetsPickerViewController) {
//        logw("Need permission to access photo library.")
//    }
//
//    func assetsPickerDidCancel(controller: AssetsPickerViewController) {
//        logi("Cancelled.")
//    }
//
//    func assetsPicker(controller: AssetsPickerViewController, selected assets: [PHAsset]) {
//        self.assets = assets
//        tableView.reloadData()
//    }
//
//    func assetsPicker(controller: AssetsPickerViewController, shouldSelect asset: PHAsset, at indexPath: IndexPath) -> Bool {
//        logi("shouldSelect: \(indexPath.row)")
//
//        // can limit selection count
//        if controller.selectedAssets.count > 3 {
//            // do your job here
//        }
//        return true
//    }
//
//    func assetsPicker(controller: AssetsPickerViewController, didSelect asset: PHAsset, at indexPath: IndexPath) {
//        logi("didSelect: \(indexPath.row)")
//    }
//
//    func assetsPicker(controller: AssetsPickerViewController, shouldDeselect asset: PHAsset, at indexPath: IndexPath) -> Bool {
//        logi("shouldDeselect: \(indexPath.row)")
//        return true
//    }
//
//    func assetsPicker(controller: AssetsPickerViewController, didDeselect asset: PHAsset, at indexPath: IndexPath) {
//        logi("didDeselect: \(indexPath.row)")
//    }
//
//    func assetsPicker(controller: AssetsPickerViewController, didDismissByCancelling byCancel: Bool) {
//        logi("dismiss completed - byCancel: \(byCancel)")
//    }
//}
