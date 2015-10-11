//
//  ViewController.swift
//  Automating UI Test Scripts
//
//  Created by Vandad on 7/6/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet var lbl: UILabel!
  @IBOutlet var txtField: UITextField!
  
  @IBAction func capitalize() {
    guard let txt = txtField.text where txt.characters.count > 0 else{
      return
    }
    lbl.text = txt.uppercaseString
    lbl.accessibilityValue = lbl.text
  }


}

