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
    
    btn2.leadingAnchor.constraint(equalTo: btn1.trailingAnchor,
      constant: 10).isActive = true
    
    v.widthAnchor.constraint(equalTo: btn2.widthAnchor,
      constant:0).isActive = true

  }

}

