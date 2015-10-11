//
//  ViewController.swift
//  Adding a Radial Gravity Field to Your UI
//
//  Created by Vandad on 8/14/15.
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
  
  lazy var centerGravity: UIFieldBehavior = {
    let centerGravity =
    UIFieldBehavior.radialGravityFieldWithPosition(self.view.center)
    centerGravity.addItem(self.orangeView)
    centerGravity.region = UIRegion(radius: 200)
    centerGravity.strength = -1 //repel items
    return centerGravity
    }()
  
  override func viewWillTransitionToSize(size: CGSize,
    withTransitionCoordinator
    coordinator: UIViewControllerTransitionCoordinator) {
      
      super.viewWillTransitionToSize(size,
        withTransitionCoordinator: coordinator)
      
      centerGravity.position = size.center
      
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    animator.addBehavior(collision)
    animator.addBehavior(centerGravity)
    
  }
  
  @IBAction func panning(sender: UIPanGestureRecognizer) {
    
    switch sender.state{
    case .Began:
      collision.removeItem(orangeView)
      centerGravity.removeItem(orangeView)
    case .Changed:
      orangeView.center = sender.locationInView(view)
    case .Ended, .Cancelled:
      collision.addItem(orangeView)
      centerGravity.addItem(orangeView)
    default: ()
    }
    
  }
  
}

