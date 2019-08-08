//
//  FolderTableViewController.swift
//  ImageStorage
//
//  Created by Jonathan Hawley on 7/26/19.
//  Copyright © 2019 Jonathan Hawley. All rights reserved.
//

import UIKit
import CoreData

class FolderTableViewController: UITableViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    var folders = [Folder]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadFolders()

        //Uncomment the line below to restore normal editing functionality
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
        
        let index = indexPath.row

        cell.folderLabel.text = folders[indexPath.row].folderName

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let index = indexPath.row
            let myFolders = folders
            
            context.delete(folders[indexPath.row])
            folders.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            saveContext()
        }
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Folder Name", message: "Please enter a name for the new folder.", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Folder Name"
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            guard let folderName = alert.textFields![0].text else {
                fatalError("Failed to retrieve folder name from text field")
            }
            
            let folder = Folder(context: self.context)
            folder.folderName = folderName
            
            self.folders.append(folder)
            self.saveContext()
            self.tableView.reloadData()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let row = tableView.indexPathForSelectedRow?.row else{ fatalError() }
        
        switch segue.identifier{
        case "showImageCollection":
            let destination = segue.destination as! ImageCollectionViewController
            destination.navigationItem.title = folders[row].folderName
            destination.parentFolder = folders[row]
        default:
            return
        }
    }
    
    private func loadFolders(){
        let request: NSFetchRequest<Folder> = Folder.fetchRequest()
        
        do{
            folders = try context.fetch(request)
        } catch{
            print("Error fetching folders: \(error)")
        }
    }
    
    private func saveContext(){
        do{
            try context.save()
        } catch{
            print("Error saving context: \(error)")
        }
    }
}
