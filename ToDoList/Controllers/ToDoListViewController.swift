//
//  ViewController.swift
//  ToDoList
//
//  Created by Akki Suju on 18/03/18.
//  Copyright © 2018 Akki Suju. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController
{
    /* Declaring an array of type Item.  Item is
     a user-defined class stored in Data Model
     folder. */
    
    var itemArray = [Item]()
    
    
    // Creating a variable of UserDefaults type
    
    let defaults = UserDefaults.standard
    

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "Item One"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Item Two"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Item Three"
        itemArray.append(newItem3)
        
        /* Here we are saving the value from the
         User Defaults to the itemArray.  Also, we
         are doing Optional Binding just to check
         if the ToDoListArray exists.
         
         We are casting User Defaults as an array of
         Strings*/
        
        if let items = defaults.array(forKey: "ToDoListArray") as? [Item]
        {
            itemArray = items
        }
    }
    
    
    
    
    
    /********************************/
    
    //MARK: - Table View Datasource Methods
    
    
    /* Refer to WhatsApp coding to get explanation
      for the below two methods. */
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        /* As we have mentioned in the begining of
         the topic that if we use Table View
         Controller then we don't have to link the
         IBOutlets.  tableView is a varibale set by
         default by the Table View Controller*/
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        
        //Using Ternary Operator to set checkmark
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell

    }
    
    
    
    
    /********************************/
    
    //MARK: - Table View Delegate Methods
    
    
    /* Refer to WhatsApp coding to get explanation
     for the below two methods. */
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        //print(itemArray[indexPath.row])
        
        /* Here we are using not operator (!).
         This will set the DONE property (we have
         defined this property in ITEM class) for the
         current item just to opposite of what it is
         already set.  It means, if DONE property is
         TRUE then it will set to FALSE, and vice-versa.
        */
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.reloadData()
        
        /* By default, on selecting a row, it gets
         permanently selected until we click on
         another row, and also the background colour
         changes.
         
         This statement will select the row just for a
         moment on clicking, and then will bring it
         back to normal. */
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    
    /********************************/
    
    //MARK: - Add new items
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem)
    {
        /* Creating a variable of UITextField type, and the
         reason is given a little below. */
        
        var textField = UITextField()
        
        /* When user clicks on the Add New Item button,
         we want to open a pop-up or a UI Alert Controller
         containing a Text Field to add a new item that we
         could add to our itemArray. */
        
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (UIAlertAction) in
            
            
            // adding the new item to the list/array
            
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            
            
            /* Here we are adding the updated array to the
             User Default. The below statement provides many
             options once we start typing set.  We have
             to chose this option -
             set(value: Any?, forKey: String)
             
             forKey would be a name that will identify the array
             inside the User Default. */
            
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            
            /* after adding new item, we are reloading the
             table to see the new item. */
            
            self.tableView.reloadData()
        }
        
        
        /* This is to put text field inside pop-up window.
         The method will provide you a placeholder for its
         argument.  Simply select the placeholder and press
         Enter to enter a Closure.
         
         It will provide two placeholders - UITextField and
         code.  Give a name to the UITextField (alertTextField
         in this case).  Delete the code placeholder and give
         your own code. */
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            
            
            /* Because the alertTextField has a scope just
             within this closure therefore we have declared
             a variable of TextField type above, and here
             storing the value of alertTextField to it, so
             that we can use it anywhere within
             addButtonPressed method. */
            
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    

}

