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

  func lblWithIndex(idx: Int) -> UILabel{
    let label = UILabel()
    label.text = "Item \(idx)"
    label.sizeToFit()
    return label
  }
  
  func newButton() -> UIButton{
    let btn = UIButton(type: .System)
    btn.setTitle("Add new items...", forState: .Normal)
    btn.addTarget(self, action: "addNewItem",
      forControlEvents: .TouchUpInside)
    return btn
  }
  
  func addNewItem(){
    let n = rightStack.arrangedSubviews.count
    let v = lblWithIndex(n)
    rightStack.insertArrangedSubview(v, atIndex: n - 1)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    rightStack = UIStackView(arrangedSubviews:
      [lblWithIndex(1), lblWithIndex(2), lblWithIndex(3), newButton()])
    
    view.addSubview(rightStack)
    
    rightStack.translatesAutoresizingMaskIntoConstraints = false
    
    rightStack.axis = .Vertical
    rightStack.distribution = .EqualSpacing
    rightStack.spacing = 5
    
    rightStack.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor,
      constant: -20).active = true
    rightStack.topAnchor.constraintEqualToAnchor(
      topLayoutGuide.bottomAnchor).active = true
    
  }

}

