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

        self.navigationItem.leftBarButtonItem = self.editButtonItem
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
        case "showImageGallery":
            let destination = segue.destination as! ImageGalleryViewController
            destination.navigationItem.title = folders[row!]
        case "showImageCollection":
            let destination = segue.destination as! ImageCollectionViewController
            destination.navigationItem.title = folders[row!] + " Gallery"
        default:
            return
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
