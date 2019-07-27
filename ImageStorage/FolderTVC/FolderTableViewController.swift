//
//  FolderTableViewController.swift
//  ImageStorage
//
//  Created by Jonathan Hawley on 7/26/19.
//  Copyright © 2019 Jonathan Hawley. All rights reserved.
//

import UIKit

class FolderTableViewController: UITableViewController {

    var folders = ["First Folder", "Second Folder", "Third Folder"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Uncomment the line below to restore normal editing functionality
//        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return folders.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "folderCell", for: indexPath) as! FolderTableViewCell

        cell.folderLabel.text = folders[indexPath.row]

        return cell
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Folder Name", message: "Please enter a name for the new folder.", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Folder Name"
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            let newIndexPath = IndexPath(row: self.folders.count, section: 0)
            self.folders.append(alert.textFields![0].text!)
            self.tableView.insertRows(at: [newIndexPath], with: .automatic)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let row = tableView.indexPathForSelectedRow?.row
        
        switch segue.identifier{
        case "showImageCollection":
            let destination = segue.destination as! ImageCollectionViewController
            destination.navigationItem.title = folders[row!] + " Gallery"
        case "showImagePicker":
            return
        default:
            return
        }
    }

    @IBAction func switchButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "showImagePicker", sender: self)
    }
    
}
