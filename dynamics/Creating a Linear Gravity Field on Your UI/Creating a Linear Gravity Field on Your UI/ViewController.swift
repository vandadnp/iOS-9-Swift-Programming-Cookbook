//
//  ViewController.swift
//  Creating a Linear Gravity Field on Your UI
//
//  Created by Vandad on 8/18/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import UIKit
import SharedCode

class ViewController: UIViewController {
  
  @IBOutlet var orangeView: UIView!
  
  lazy var animator: UIDynamicAnimator = {
    let animator = UIDynamicAnimator(referenceView: self.view)
    animator.debugEnabled = true
    return animator
    }()
  
  lazy var collision: UICollisionBehavior = {
    let collision = UICollisionBehavior(items: [self.orangeView])
    collision.translatesReferenceBoundsIntoBoundary = true
    return collision
    }()
  
  lazy var gravity: UIFieldBehavior = {
    let vector = CGVector(dx: 0.4, dy: 1.0)
    let gravity =
    UIFieldBehavior.linearGravityFieldWithVector(vector)
    gravity.addItem(self.orangeView)
    return gravity
    }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    animator.addBehavior(collision)
    animator.addBehavior(gravity)
    
  }
  
  @IBAction func panning(sender: UIPanGestureRecognizer) {
    
    switch sender.state{
    case .Began:
      collision.removeItem(orangeView)
      gravity.removeItem(orangeView)
    case .Changed:
      orangeView.center = sender.locationInView(view)
    case .Ended, .Cancelled:
      collision.addItem(orangeView)
      gravity.addItem(orangeView)
    default: ()
    }
    
  }
  
}



