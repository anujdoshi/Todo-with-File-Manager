//
//  TableViewController.swift
//  Todo
//
//  Created by Anuj Doshi on 28/01/20.
//  Copyright © 2020 Anuj Doshi. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var itemArray = [Item]()
    var filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("ItemList")
    var topicName:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.tableView.gradientSetColor(colorOne: Color.purple, colorTwo: Color.darkPurple)
        let newItem = Item()
        newItem.itemName = "Home"
        itemArray.append(newItem)
        loadData()

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "item",for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row].itemName
        cell.gradientSetColor(colorOne: Color.lost, colorTwo: Color.lostMemory)
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        topicName = itemArray[indexPath.row].itemName
        performSegue(withIdentifier: "details", sender: self)
    }
    
    
    @IBAction func addItemBtn(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Topic", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Topic", style: .default) { (UIAlertAction) in
            let newItem = Item()
            newItem.itemName = textField.text!
            self.itemArray.append(newItem)
            self.saveItem()
            self.tableView.reloadData()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add new topic to a todo list"
            textField = alertTextField
            
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    func loadData(){
       
        if let data = try? Data(contentsOf: filePath!){
            let decoder = PropertyListDecoder()
            do{
                itemArray = try decoder.decode([Item].self, from: data)
            }
            catch{
                print("Error")
            }
        }
        self.tableView.reloadData()
    }
    func saveItem(){
        let encoder = PropertyListEncoder()
        do{
            let data = try encoder.encode(itemArray)
            try data.write(to: filePath!)
        }catch{
            print("Error")
        }
        self.tableView.reloadData()
    }
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let more = UIContextualAction(style: .normal, title: "More Details") { (ac:UIContextualAction, view:UIView, sucess:(Bool) -> Void) in
            sucess(true)

        }
        
        more.backgroundColor = .brown
        
        return UISwipeActionsConfiguration(actions: [more])
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! ItemListTableViewController
        vc.topicName = topicName
    }
}

