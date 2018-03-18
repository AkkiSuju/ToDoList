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
    let itemArray = ["Item One", "Item Two", "Item Three"]

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
 

}

