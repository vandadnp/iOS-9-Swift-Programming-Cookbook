//
//  ViewController.swift
//  Creating a Magnetic Effect Between UI Components
//
//  Created by Vandad on 8/18/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import UIKit
import SharedCode

class ViewController: UIViewController {
  
  @IBOutlet var views: [UIView]!
  
  lazy var animator: UIDynamicAnimator = {
    let animator = UIDynamicAnimator(referenceView: self.view)
    animator.isDebugEnabled = true
    return animator
    }()
  
  lazy var collision: UICollisionBehavior = {
    let collision = UICollisionBehavior(items: self.views)
    collision.translatesReferenceBoundsIntoBoundary = true
    return collision
    }()
  
  lazy var noise: UIFieldBehavior = {
    let noise = UIFieldBehavior.noiseField(smoothness: 0.9,
      animationSpeed: 1)
    noise.addItems(self.views)
    return noise
    }()
  
  lazy var magnet: UIFieldBehavior = {
    let magnet = UIFieldBehavior.magneticField()
    magnet.addItems(self.views)
    return magnet
  }()
  
  var behaviors: [UIDynamicBehavior]{
    return [collision, noise, magnet]
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    animator.addBehaviors(behaviors)
  }

}

