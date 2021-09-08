//
//  TodoTableViewController.swift
//  Todo
//
//  Created by Jeremy Warren on 9/8/21.
//

import UIKit

class TodoTableViewController: UITableViewController {
    
    let manager = TodoNoteManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return manager.todoNotes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath)
        
        let note = manager.todoNotes[indexPath.row]
        cell.textLabel?.text = note.title
        cell.detailTextLabel?.text = note.subtitle
        
        return cell
    }
    

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let note = manager.todoNotes[indexPath.row]
            
            manager.deleteTodo(note: note)
            
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {

        let alert = UIAlertController(title: "New Note", message: "Write a title!", preferredStyle: .alert)
        
        alert.addTextField()
        alert.addTextField()
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancelButton)
        let saveButton = UIAlertAction(title: "Save", style: .default) { _ in
            // get the text fields
            guard let titleField = alert.textFields?.first,
                  let subtitleField = alert.textFields?.last else { return }
            // get title and subtitle
            let title = titleField.text ?? "Untitled"
            let subtitle = subtitleField.text ?? ""
            // create new note
            self.manager.createTodo(title: title, subtitle: subtitle)
            
            // reload the tableview
            self.tableView.reloadData()
            
        }
        alert.addAction(saveButton)
        
        
        
        present(alert, animated: true)

    }
    
    
}
