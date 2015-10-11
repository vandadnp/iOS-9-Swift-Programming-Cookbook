//
//  ViewController.swift
//  Testing Text Fields, Buttons and Labels
//
//  Created by Vandad on 7/6/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet var lbl: UILabel!
  
  @IBAction func hideLabel() {
    lbl.removeFromSuperview()
  }

}

