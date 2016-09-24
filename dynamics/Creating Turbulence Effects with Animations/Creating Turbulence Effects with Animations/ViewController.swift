//
//  ViewController.swift
//  Creating Turbulence Effects with Animations
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
    animator.isDebugEnabled = true
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
    UIFieldBehavior.linearGravityField(direction: vector)
    gravity.strength = 10.0
    gravity.addItem(self.orangeView)
    return gravity
    }()
  
  lazy var turbulence: UIFieldBehavior = {
    let turbulence = UIFieldBehavior.turbulenceField(smoothness: 0.5,
      animationSpeed: 60.0)
    turbulence.strength = 12.0
    turbulence.region = UIRegion(radius: 200.0)
    turbulence.position = self.orangeView.bounds.size.center
    turbulence.addItem(self.orangeView)
    return turbulence
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    animator.addBehavior(collision)
    animator.addBehavior(gravity)
    animator.addBehavior(turbulence)
    
  }
  
  @IBAction func panning(_ sender: UIPanGestureRecognizer) {
    
    switch sender.state{
    case .began:
      collision.removeItem(orangeView)
      gravity.removeItem(orangeView)
      turbulence.removeItem(orangeView)
    case .changed:
      orangeView.center = sender.location(in: view)
    case .ended, .cancelled:
      collision.addItem(orangeView)
      gravity.addItem(orangeView)
      turbulence.addItem(orangeView)
    default: ()
    }
    
  }
  
}

