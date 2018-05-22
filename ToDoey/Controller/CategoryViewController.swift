//
//  TableViewController.swift
//  ToDoey
//
//  Created by Vigneshraj Sekar Babu on 5/19/18.
//  Copyright © 2018 Vigneshraj Sekar Babu. All rights reserved.
//

import UIKit
import CoreData

class CategoryTableViewController: UITableViewController {
    
    @IBOutlet weak var searchBarCategory: UISearchBar!
    var array = [Category]()
    let context = ((UIApplication.shared.delegate) as! AppDelegate).persistentContainer.viewContext

    var selectedCat = Category()

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBarCategory.delegate = self
        fetchCategory()
    
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return array.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        
        cell.textLabel?.text = array[indexPath.row].categoryName

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (array[indexPath.row].categoryName != nil) {
       
            selectedCat = array[indexPath.row]
        } else
        {
            print("category name for the row is nil")
        }
        
        performSegue(withIdentifier: "goToListItems", sender: self)
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let toDoList = segue.destination as! ToDoListViewController
      //  toDoList.categorySelected = selected
        toDoList.category = selectedCat
    }
 
    
    @IBAction func addCategoryPressed(_ sender: UIBarButtonItem) {
        //print("Add Category")
        var categoryTextBox = UITextField()
        let alert = UIAlertController(title: "Add Category", message: "Enter the Category", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            if categoryTextBox.text!.count > 0 {
            //self.array.append(categoryTextBox.text!)
                
               let categoryContext = Category(context: self.context)
                categoryContext.categoryName = categoryTextBox.text!
                self.saveCategory()
                self.fetchCategory()
                
            } else
            {
                print("no text entered")
            }
            
        }
        alert.addAction(action)
        alert.addTextField { (textBox) in
            categoryTextBox.placeholder = "Category here"
            categoryTextBox = textBox
        }
        present(alert, animated: true)
    }
    
    func saveCategory() {
        do {
            try self.context.save()
        } catch {
            print("error while saving category : \(error)")
        }
        //tableView.reloadData()
    }
    
    func fetchCategory(with request : NSFetchRequest<Category> = NSFetchRequest(entityName: "Category")) {
     //   let requestCat : NSFetchRequest<Category> = NSFetchRequest(entityName: "Category")
   
        do {
        try array = context.fetch(request)
        } catch {
            print("error when fetching category : \(error)")
        }
        
        tableView.reloadData()
    }
    

}

// MARK: - search bar functionality

extension CategoryTableViewController : UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        let searchRequest : NSFetchRequest<Category> = NSFetchRequest(entityName: "Category")
        searchRequest.predicate = NSPredicate(format: "categoryName CONTAINS[cd] %@", searchBarCategory.text!)
        fetchCategory(with: searchRequest)
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        if searchBarCategory.text!.count == 0 {
            fetchCategory()
            DispatchQueue.main.async {
                self.searchBarCategory.resignFirstResponder()
                
            }
            
        }
    }
    
}

