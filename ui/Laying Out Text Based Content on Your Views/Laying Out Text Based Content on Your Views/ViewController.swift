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
    label.backgroundColor = UIColor.green
    label.text = "Hello, World"
    label.sizeToFit()
    view.addSubview(label)
    
    label.leadingAnchor.constraint(
      equalTo: view.readableContentGuide.leadingAnchor).isActive = true
    
    label.topAnchor.constraint(
      equalTo: view.readableContentGuide.topAnchor).isActive = true
    
    label.trailingAnchor.constraint(
      equalTo: view.readableContentGuide.trailingAnchor).isActive = true
    
    label.bottomAnchor.constraint(
      equalTo: view.readableContentGuide.bottomAnchor).isActive = true
    
  }

}

