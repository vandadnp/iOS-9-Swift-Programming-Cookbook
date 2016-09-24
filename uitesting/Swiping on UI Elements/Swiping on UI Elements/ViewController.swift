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

  override func tableView(_ tableView: UITableView,
    numberOfRowsInSection section: Int) -> Int {
    return items.count
  }
  
  override func tableView(_ tableView: UITableView,
    cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
      let c = tableView.dequeueReusableCell(withIdentifier: id,
        for: indexPath)
      
      c.textLabel!.text = items[(indexPath as NSIndexPath).row]
      
      return c
      
  }
  
  override func tableView(_ tableView: UITableView,
    commit editingStyle: UITableViewCellEditingStyle,
    forRowAt indexPath: IndexPath) {
    
      items.remove(at: (indexPath as NSIndexPath).row)
      tableView.deleteRows(at: [indexPath],
        with: .automatic)
      
  }
  
}

