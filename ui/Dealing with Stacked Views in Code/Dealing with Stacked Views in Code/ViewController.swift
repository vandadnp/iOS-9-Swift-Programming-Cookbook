//
//  ViewController.swift
//  Dealing with Stacked Views in Code
//
//  Created by Vandad on 7/1/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  var rightStack: UIStackView!

  func lblWithIndex(_ idx: Int) -> UILabel{
    let label = UILabel()
    label.text = "Item \(idx)"
    label.sizeToFit()
    return label
  }
  
  func newButton() -> UIButton{
    let btn = UIButton(type: .system)
    btn.setTitle("Add new items...", for: UIControlState())
    btn.addTarget(self, action: #selector(ViewController.addNewItem),
      for: .touchUpInside)
    return btn
  }
  
  func addNewItem(){
    let n = rightStack.arrangedSubviews.count
    let v = lblWithIndex(n)
    rightStack.insertArrangedSubview(v, at: n - 1)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    rightStack = UIStackView(arrangedSubviews:
      [lblWithIndex(1), lblWithIndex(2), lblWithIndex(3), newButton()])
    
    view.addSubview(rightStack)
    
    rightStack.translatesAutoresizingMaskIntoConstraints = false
    
    rightStack.axis = .vertical
    rightStack.distribution = .equalSpacing
    rightStack.spacing = 5
    
    rightStack.trailingAnchor.constraint(equalTo: view.trailingAnchor,
      constant: -20).isActive = true
    rightStack.topAnchor.constraint(
      equalTo: topLayoutGuide.bottomAnchor).isActive = true
    
  }

}

