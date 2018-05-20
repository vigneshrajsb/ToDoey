//
//  ViewController.swift
//  ToDoey
//
//  Created by Vigneshraj Sekar Babu on 5/11/18.
//  Copyright © 2018 Vigneshraj Sekar Babu. All rights reserved.
//

import UIKit
import CoreData

class ToDoListViewController: UITableViewController {
    
    var array  = [Entity]()
    // var defaults = UserDefaults.standard
   // let dataFilepath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    let context = ((UIApplication.shared.delegate) as! AppDelegate).persistentContainer.viewContext
    
    
//    var itemObject = ListItem()
//    var itemObject2 = ListItem()
//    var itemsObject3 = ListItem()
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //print(defaults.array(forKey: "ToDoListUserDefaultArray" as String)!)
      //print(" This is the path \(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))")
        
        //guard if the defaults values are nil
        // guard let temp = defaults.array(forKey: "") as? [String] else { return }
        //array = temp
//        itemObject.itemToDo = "This is object 1"
//        array.append(itemObject)
//        itemObject2.itemToDo = "second item "
//        array.append(itemObject2)
//        itemsObject3.itemToDo   = "third item"
//        array.append(itemsObject3)
        
      fetchData()
        
    }

    
    
    // MARK:  Create the table view setup here
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "ToDoListItem", for: indexPath)
        let tempArray = array[indexPath.row]
       
       cell.textLabel?.text = tempArray.itemToDo
        // Ternary Operator
        // value = condition ? valueifTrue : valueifFalse
        cell.accessoryType = tempArray.itemChecked ? .checkmark : .none
        
    
        
        //all the below lines are transformed to 2 lines due to ternary operators
//        if tempArray.itemChecked == true {
//            cell.accessoryType = .checkmark
//            cell.textLabel?.textColor = UIColor.red
//        } else {
//            cell.accessoryType = .none
//            cell.textLabel?.textColor = UIColor.black
//        }
        return cell
    }

    
    // MARK: table view delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //to delete the record in the table
       // context.delete(array[indexPath.row])
        //array.remove(at: indexPath.row)
        
        array[indexPath.row].itemChecked = !array[indexPath.row].itemChecked
        tableView.deselectRow(at: indexPath, animated: true)
       saveData()
        
    }
    
    // MARK: Add bar button code
    
    @IBAction func addPressed(_ sender: UIBarButtonItem) {
        var textEntered = UITextField()
        let alert = UIAlertController(title: "Enter Task", message: "" , preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            if textEntered.text != "" {
              //  let itemAdded = ListItem()
                let itemAdded =  Entity(context: self.context)
                itemAdded.itemToDo = textEntered.text!
                itemAdded.itemChecked = false
                //self.array.append(itemAdded)
                //self.defaults.set(self.array, forKey: "ToDoListUserDefaultArray")
            
                self.saveData()
            } else{
                print("nothing entered in enter task text box") }
        }
        
        alert.addAction(action)
        alert.addTextField { (textField) in
             textField.placeholder = "Enter here"
            //print(textField.text!)
            textEntered = textField
        }
        present(alert, animated: true)
        
        
    }

    
    func saveData() {
        
        do {
            try context.save()
        } catch {
            print("error saving context : \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    func fetchData(){
        //fetching core data
        let request : NSFetchRequest<Entity> = Entity.fetchRequest()
        do {
            array  = try context.fetch(request)
        } catch {
            print("Error fetching data from context : \(error)")
        }
        
        
        
        //below code was used for the NSCoder method
//        if let data = try? Data(contentsOf: dataFilepath!) {
//            let decoder = PropertyListDecoder()
//            do {
//                array = try decoder.decode([ListItem].self, from: data)
//            } catch {
//                print("error during decoding \(error)")
//            }
//        }

    }


}

