//
//  ViewController.swift
//  ToDoey
//
//  Created by Vigneshraj Sekar Babu on 5/11/18.
//  Copyright © 2018 Vigneshraj Sekar Babu. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    var array  = ["Return laptop","TAS function","study iOS", "movie?"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    
    
    // MARK:  Create the table view setup here
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "ToDoListItem", for: indexPath)
        cell.textLabel?.text = array[indexPath.row]
             
        return cell
    }

    
    // MARK: table view delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
    }
    
    // MARK: Add bar button code
    
    @IBAction func addPressed(_ sender: UIBarButtonItem) {
        var textEntered = UITextField()
        let alert = UIAlertController(title: "Enter Task", message: "" , preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            if textEntered.text != "" {
            self.array.append(textEntered.text!)
                self.tableView.reloadData()
            } else{
                print("nothing entered") }
        }
        
        alert.addAction(action)
        alert.addTextField { (textField) in
             textField.placeholder = "enter here"
            print(textField.text!)
            textEntered = textField
        }
        present(alert, animated: true)
        
        
    }
    


}

