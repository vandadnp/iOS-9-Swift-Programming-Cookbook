//
//  ViewController.swift
//  Associating Keyboard Shortcuts with View Controllers
//
//  Created by Vandad on 7/8/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import UIKit

func +<T: OptionSet>
  (lhs: T, rhs: T) -> T where T.RawValue : SignedInteger{
    return T(rawValue: lhs.rawValue | rhs.rawValue)
}

class ViewController: UIViewController {
  
  func handleCommand(_ cmd: UIKeyCommand){
    
    let c = UIAlertController(title: "Shortcut pressed",
      message: "You pressed the shortcut key", preferredStyle: .alert)
    
    c.addAction(UIAlertAction(title: "Ok!", style: .destructive, handler: nil))
    
    present(c, animated: true, completion: nil)
    
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let command = UIKeyCommand(input: "N",
      modifierFlags: .command + .alternate + .control,
      action: #selector(ViewController.handleCommand(_:)))
    
    addKeyCommand(command)
    
  }

}
