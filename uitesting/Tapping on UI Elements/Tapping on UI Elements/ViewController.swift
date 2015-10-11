//
//  ViewController.swift
//  Tapping on UI Elements
//
//  Created by Vandad on 7/8/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  func handleTap(){
    view.accessibilityValue = "tapped"
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.isAccessibilityElement = true
    view.accessibilityValue = "untapped"
    view.accessibilityLabel = "myView"
    
    let tgr = UITapGestureRecognizer(target: self, action: "handleTap")
    tgr.numberOfTapsRequired = 1
    tgr.numberOfTouchesRequired = 2
    view.addGestureRecognizer(tgr)
    
  }

}

