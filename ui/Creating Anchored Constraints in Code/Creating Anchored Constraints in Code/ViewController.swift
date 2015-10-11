//
//  ViewController.swift
//  Creating Anchored Constraints in Code
//
//  Created by Vandad on 6/29/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet var btn1: UIButton!
  @IBOutlet var btn2: UIButton!
  @IBOutlet var v: UIView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    btn2.leadingAnchor.constraintEqualToAnchor(btn1.trailingAnchor,
      constant: 10).active = true
    
    v.widthAnchor.constraintEqualToAnchor(btn2.widthAnchor,
      constant:0).active = true

  }

}

