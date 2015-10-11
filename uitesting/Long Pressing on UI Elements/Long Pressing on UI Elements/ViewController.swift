//
//  ViewController.swift
//  Long Pressing on UI Elements
//
//  Created by Vandad on 7/7/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  func handleLongPress(){
    let c = UIAlertController(title: "Name", message: "What is your name?",
      preferredStyle: .Alert)
    
    c.addAction(UIAlertAction(title: "Cancel", style: .Destructive,
      handler: nil))
    
    c.addAction(UIAlertAction(title: "Save", style: .Destructive){
      action in
      
      guard let fields = c.textFields where fields.count == 1 else{
        return
      }
      
      let txtField = fields[0]
      guard let txt = txtField.text where txt.characters.count > 0 else{
        return
      }
      
      self.view.accessibilityValue = txt
      
      })
    
    c.addTextFieldWithConfigurationHandler {txt in
      txt.placeholder = "Foo Bar"
    }
    
    presentViewController(c, animated: true, completion: nil)
    
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.isAccessibilityElement = true
    
    let gr = UILongPressGestureRecognizer(target: self,
      action: "handleLongPress")
    
    gr.minimumPressDuration = 5
    
    view.addGestureRecognizer(gr)
    
  }
  
}

