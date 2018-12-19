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
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    var itemArray = [Item]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Load the items from the user prefs
        
        
        
        print("Data file path: \(dataFilePath!)")
        
        
        loadItems()
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
        
        saveItems()
        
        
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
            self.saveItems()
            
            
            
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Create new item"
            newTextField = textField
            
        }
        
        
        alert.addAction(action)
        present(alert,animated: true,completion: nil)
        
    }
    
    func saveItems(){
        let encoder = PropertyListEncoder()
        
        do{
            
            let arrayData = try encoder.encode(itemArray)
            try arrayData.write(to: dataFilePath!)
            
            
        }catch{
            
            print("Encoding error: \(error)")
        }
        
        
        tableView.reloadData()
        
    }
    
    func loadItems() {
        
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            
            do{
                itemArray = try decoder.decode([Item].self, from: data)
                
            }catch{
                print(error)
            }
            
        }
        
        
        
        
        tableView.reloadData()
    }
}

