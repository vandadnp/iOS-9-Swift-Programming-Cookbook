//
//  ViewController.swift
//  Laying Out Text Based Content on Your Views
//
//  Created by Vandad on 7/2/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.backgroundColor = UIColor.greenColor()
    label.text = "Hello, World"
    label.sizeToFit()
    view.addSubview(label)
    
    label.leadingAnchor.constraintEqualToAnchor(
      view.readableContentGuide.leadingAnchor).active = true
    
    label.topAnchor.constraintEqualToAnchor(
      view.readableContentGuide.topAnchor).active = true
    
    label.trailingAnchor.constraintEqualToAnchor(
      view.readableContentGuide.trailingAnchor).active = true
    
    label.bottomAnchor.constraintEqualToAnchor(
      view.readableContentGuide.bottomAnchor).active = true
    
  }

}

