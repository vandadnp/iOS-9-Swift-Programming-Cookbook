//
//  ViewController.swift
//  Associating Keyboard Shortcuts with View Controllers
//
//  Created by Vandad on 7/8/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import UIKit

func +<T: OptionSetType where T.RawValue : SignedIntegerType>
  (lhs: T, rhs: T) -> T{
    return T(rawValue: lhs.rawValue | rhs.rawValue)
}

class ViewController: UIViewController {
  
  func handleCommand(cmd: UIKeyCommand){
    
    let c = UIAlertController(title: "Shortcut pressed",
      message: "You pressed the shortcut key", preferredStyle: .Alert)
    
    c.addAction(UIAlertAction(title: "Ok!", style: .Destructive, handler: nil))
    
    presentViewController(c, animated: true, completion: nil)
    
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let command = UIKeyCommand(input: "N",
      modifierFlags: .Command + .Alternate + .Control,
      action: "handleCommand:")
    
    addKeyCommand(command)
    
  }

}
