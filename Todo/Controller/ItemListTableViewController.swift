//
//  ItemListTableViewController.swift
//  Todo
//
//  Created by Anuj Doshi on 28/01/20.
//  Copyright © 2020 Anuj Doshi. All rights reserved.
//

import UIKit

class ItemListTableViewController: UITableViewController {
    var topicName:String = ""
    var filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item.plist")
    var itemArray = [ItemList]()
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemList", for: indexPath)
        cell.gradientSetColor(colorOne: Color.lost, colorTwo: Color.lostMemory)
        if topicName == itemArray[indexPath.row].topicName{
            cell.textLabel?.text = itemArray[indexPath.row].item
            cell.accessoryType = itemArray[indexPath.row].done ? .checkmark : .none
            
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done

        saveItem()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func loadData(){
        if let data = try? Data(contentsOf: filePath!)
        {
            let decoder = PropertyListDecoder()
            do{
                itemArray = try decoder.decode([ItemList].self, from: data)
                let item = try decoder.decode([ItemList].self, from: data)
                let count : Int = itemArray.count
                for i in 0..<count
                {
                    if topicName == item[i].topicName{
                        
                    }
                }
                
                
            }catch{
                print("Error")
            }
        }
    }
    func saveItem(){
        let encoder = PropertyListEncoder()
        do{
            let data = try encoder.encode(itemArray)
            try data.write(to:filePath!)
            
        }
        catch{
            print("Error")
        }
        self.tableView.reloadData()
    }
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: "Delete") { (ac:UIContextualAction, view:UIView, sucess:(Bool) -> Void) in
            sucess(true)

        }
        
        delete.backgroundColor = .red
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    @IBAction func addItembtn(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (UIAlertAction) in
            let newItem = ItemList()
            newItem.item = textField.text!
            newItem.topicName = self.topicName
            self.itemArray.append(newItem)
            self.saveItem()
            self.tableView.reloadData()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "New Item"
            textField = alertTextField
            
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}
