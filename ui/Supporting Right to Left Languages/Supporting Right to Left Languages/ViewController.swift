//
//  ViewController.swift
//  Supporting Right to Left Languages
//
//  Created by Vandad on 7/8/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet var txtField: UITextField!
  
  @IBAction func up() {
    txtField.text = NSLocalizedString("up", comment: "")
  }
  
  @IBAction func left() {
    txtField.text = NSLocalizedString("left", comment: "")
  }
  
  @IBAction func down() {
    txtField.text = NSLocalizedString("down", comment: "")
  }
  
  @IBAction func right() {
    txtField.text = NSLocalizedString("right", comment: "")
  }
  
  override func viewDidAppear(_ animated: Bool) {
    
    let direction = UIView
      .userInterfaceLayoutDirection(
        for: txtField.semanticContentAttribute)
    
    switch direction{
    case .leftToRight:
      txtField.textAlignment = .left
    case .rightToLeft:
      txtField.textAlignment = .right
    }
    
  }

}

