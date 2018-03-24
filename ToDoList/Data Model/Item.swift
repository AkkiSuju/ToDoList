//
//  Item.swift
//  ToDoList
//
//  Created by Akki Suju on 21/03/18.
//  Copyright © 2018 Akki Suju. All rights reserved.
//

import Foundation


/* We will use this class as a blueprint to
 create items for our To Do List.
 
 We are also conforming to the protocol
 Codable.  It means that the item type is
 now enable to encode as well as decode itself
 to an external representations, such as -
 plist, JSON etc.
 
 To be able to a Codable, a class must
 have only standard data types. */

class Item: Codable
{
    var title: String = ""
    var done: Bool = false
}

