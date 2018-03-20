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
    var itemArray = ["Item One", "Item Two", "Item Three"]
    
    
    /* UserDefaults is an interface to the user's
     default DB, where you store key-value pairs
     persistently across invocations of your app
     on a given device.
     
     One imp thing to mention here is that User
     Defaults get saved in a plist file. Therefore,
     everything you save in User Defaults should be
     in a key-value pair. */
    
    let defaults = UserDefaults.standard

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        /* Here we are saving the value from the
         User Defaults to the itemArray.  Also, we
         are doing Optional Binding just to check
         if the ToDoListArray exists.
         
         We are casting User Defaults as an array of
         Strings*/
        
        if let items = defaults.array(forKey: "ToDoListArray") as? [String]
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
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell

    }
    
    
    
    
    /********************************/
    
    //MARK: - Table View Delegate Methods
    
    
    /* Refer to WhatsApp coding to get explanation
     for the below two methods. */
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        //print(itemArray[indexPath.row])
        
        /* this is to put a checkmark against the row
          that user clicks. And, if user clicks it again
         the checkmark will get removed. */
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark
        {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else
        {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        /* By default, on selecting a row, it gets
         permanently selected until we click on
         another row, and also the background colour
         changes.
         
         This statement will select the row for a
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
            self.itemArray.append(textField.text!)
            
            
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

