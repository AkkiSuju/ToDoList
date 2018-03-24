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
    
    
    /* Here we are creating a file path to
     Documents folder. To understand it better
     see the video of Sandboxing (Section 19,
     Lecture 245)
     
     File Manager provides a convenient
     interface to the contents of the file
     system.
     
     Here we are tapping into Document Directory,
     and we are looking for it inside User Domain
     Mask i.e. user's home directory, that place
     where we are saving their personal items
     associated with this app.
     
     The urls method returns an array of URLs for
     the specified directory, so, we are grabbing
     its first item.
     
     We are adding a component i.e. a file to this
     path, which is a plist file in this case.
     And we will use this file to save user data
     persistently. */
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        /* This is to print the path of the Items.plist
         file, just to get the idea that where it gets
         saved. */
        
        print(dataFilePath)
        
        /* call to the loadItems method to retrieve
         the data from the plist file. */
        
        loadItems()
        
    }
    
    
    
    
    
    /********************************/
    
    //MARK: - Table View DataSource Methods
    
    
    /* Refer to WhatsApp coding to get explanation
     for the below two methods. */
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
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
     for the below two methods.
     
     A little bit of explanation is as such, when
     user will click a row then this method will
     execute, and will put or remove checkmark on
     that row. */
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        /* Here we are using not operator (!).
         This will set the DONE property (we have
         defined this property in ITEM class) for the
         current item just to opposite of what it is
         already set.  It means, if DONE property is
         TRUE then it will set to FALSE, and vice-versa.
         
         Then with the help of this property we can
         check and uncheck the checkmark on a cell/row
         inside cellForRowAtIndexPath method above.
         */
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        
        /* The above statement will set the DONE
         property, and accordingly checkmark wil be
         visible or invisible on a row in Table View.
         
         But we have to save that status of DONE property
         in the plist file too, therefore, here we are
         calling the saveItems method to save the
         DONE property in the plist file. */
        
        saveItems()
        
        
        
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
            
            
            /* Calling the saveItems method to save the
             itemArray to the plist file. */
            
            self.saveItems()
            
        }
        
        
        /* This is to put text field inside pop-up window.
         The method will provide you a placeholder for its
         argument.  Simply select the placeholder and press
         Enter to enter a Closure.
         
         It will provide two placeholders - UITextField and
         code.  Give a name to the UITextField (alertTextField
         in this case).  Delete the code placeholder and give
         your own code. */
        
        alert.addTextField { (alertTextField) in alertTextField.placeholder = "Create new item"
            
            
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
    
    
    
    
    /********************************/
    
    //MARK: - Model Manupulation Method
    
    
    /* Defining a use defined method that will save the
     itemArray to the plist file. */
    
    func saveItems()
    {
        /* Here we creating an object of
         PropertyListEncoder, which encodes instances of
         data types from a property list. */
        
        let encoder = PropertyListEncoder()
        
        
        /* Here we are encoding the itemArray and then
         writing it to the data file path.  Because both
         of the statements could throw exception,
         therefore, have enclosed them in do-catch block.
         */
        
        do
        {
            let data = try encoder.encode(itemArray)
            
            try data.write(to: dataFilePath!)
        }
        catch
        {
            print("Error encoding item array, \(error)")
        }
        
        /* after adding new item, we are reloading the
         table to see the new item. */
        
        tableView.reloadData()
        
    }
    
    
    /* This is the user-defined method to decode and
     retrieve the data from the plist file.
     */
    
    func loadItems()
    {
        /* contentsOf method can throw an exception,
         therefore, we have done optional binding with
         it.  And the reason of optional binding instead
         of do-catch block is bcz we don't have to treat
         with the error msg. */
        
        if let data = try? Data(contentsOf: dataFilePath!)
        {
            let decoder = PropertyListDecoder()
            do
            {
                itemArray = try decoder.decode([Item].self, from: data)
            }
            catch
            {
                print("Error decoding item array, \(error)")
            }
        }
    }
    
}
