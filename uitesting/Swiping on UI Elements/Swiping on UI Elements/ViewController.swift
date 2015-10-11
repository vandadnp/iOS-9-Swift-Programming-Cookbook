//
//  ViewController.swift
//  Swiping on UI Elements
//
//  Created by Vandad on 7/7/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
  
  let id = "c"
  
  lazy var items: [String] = {
    return Array(0..<10).map{"Item \($0)"}
  }()

  override func tableView(tableView: UITableView,
    numberOfRowsInSection section: Int) -> Int {
    return items.count
  }
  
  override func tableView(tableView: UITableView,
    cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
      let c = tableView.dequeueReusableCellWithIdentifier(id,
        forIndexPath: indexPath)
      
      c.textLabel!.text = items[indexPath.row]
      
      return c
      
  }
  
  override func tableView(tableView: UITableView,
    commitEditingStyle editingStyle: UITableViewCellEditingStyle,
    forRowAtIndexPath indexPath: NSIndexPath) {
    
      items.removeAtIndex(indexPath.row)
      tableView.deleteRowsAtIndexPaths([indexPath],
        withRowAnimation: .Automatic)
      
  }
  
}

