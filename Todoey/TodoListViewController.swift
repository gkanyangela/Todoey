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
    
    var itemArray = ["Find Mike", "Buy Eggos", "Destroy Demagorgon"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Load the items from the user prefs
        if let items = defaults.array(forKey: "TodoListArray") as? [String]{
            itemArray = items
        }
    }
    
    //MARK: Tableview datasource methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    //MARK: Tableview delegate methods
    
    //Get what item has been clicked
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //Put up the checkmark when an item is selected
        
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            
        }else{
            // if the row already has a checkmark, remove it
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        //Remove the selection after the item has been clicked so that it is not always highlighted gray
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    //MARK: Add new items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var newTextField = UITextField()
        
        let alert = UIAlertController(title: "Add new Todoey item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            
            //What will happen when the user clicks the add item button
            
            self.itemArray.append(newTextField.text!)
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

