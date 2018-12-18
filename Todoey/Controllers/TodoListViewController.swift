//
//  ViewController.swift
//  Todoey
//
//  Created by Gideon Kanyangela on 2018/12/17.
//  Copyright © 2018 Paperless Software Solution. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    let defaults = UserDefaults.standard
    
    var itemArray = [Item]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Load the items from the user prefs
        
//        let newItem = Item()
//        newItem.title = "Find Mike"
//        itemArray.append(newItem)
        
        
        if let items = defaults.array(forKey: "TodoListArray") as? [Item]{
            
            itemArray = items
            
        }
    }
    
    //MARK: Tableview datasource methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    //MARK: Tableview delegate methods
    
    //Get what item has been clicked
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //Put up the checkmark when an item is selected
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        //Reload the data
        tableView.reloadData()
        
        //Remove the selection after the item has been clicked so that it is not always highlighted gray
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //MARK: Add new items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var newTextField = UITextField()
        
        let alert = UIAlertController(title: "Add new Todoey item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            
            //What will happen when the user clicks the add item button
            let newItem = Item()
            newItem.title = newTextField.text!
            
            self.itemArray.append(newItem)
            
            self.tableView.reloadData()
            
            //Save the array to user defaults. Similar to Android SharedPreferences
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Create new item"
            newTextField = textField
            
        }
        
        
        alert.addAction(action)
        present(alert,animated: true,completion: nil)
        
    }
}

