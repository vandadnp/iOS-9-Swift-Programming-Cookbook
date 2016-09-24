//
//  ViewController.swift
//  Detecting Collisions Between Non-Rectangular UI Components
//
//  Created by Vandad on 8/19/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import UIKit
import SharedCode

extension StrideThrough{
  func forEach(_ f: (Iterator.Element) -> Void){
    for item in self{
      f(item)
    }
  }
}

class PentagonView : UIView{
  
  fileprivate var diameter: CGFloat = 0.0
  
  class func pentagonViewWithDiameter(_ diameter: CGFloat) -> PentagonView{
    return PentagonView(diameter: diameter)
  }
  
  init(diameter: CGFloat){
    self.diameter = diameter
    super.init(frame: CGRect(x: 0, y: 0, width: diameter, height: diameter))
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  var radius: CGFloat{
    return diameter / 2.0
  }
  
  func pointFromAngle(_ angle: Double) -> CGPoint{
    
    let x = radius + (radius * cos(CGFloat(angle)))
    let y = radius + (radius * sin(CGFloat(angle)))
    return CGPoint(x: x, y: y)
    
  }
  
  lazy var path: UIBezierPath = {
    let path = UIBezierPath()
    path.move(to: self.pointFromAngle(0))
    
    let oneSlice = (M_PI * 2.0) / 5.0
    let lessOneSlice = (M_PI * 2.0) - oneSlice
    
    stride(from: oneSlice, through: lessOneSlice, by: oneSlice).forEach{
      path.addLine(to: self.pointFromAngle($0))
    }
    
    path.close()
    return path
    }()
  
  override func draw(_ rect: CGRect) {
    guard let context = UIGraphicsGetCurrentContext() else{
      return
    }
    UIColor.clear.setFill()
    context.fill(rect)
    UIColor.yellow.setFill()
    path.fill()
  }
  
  override var collisionBoundsType: UIDynamicItemCollisionBoundsType{
    return UIDynamicItemCollisionBoundsType.path
  }
  
  override var collisionBoundingPath: UIBezierPath{
    let path = self.path.copy() as! UIBezierPath
    path.apply(CGAffineTransform(translationX: -radius, y: -radius))
    return path
  }
  
}

extension UIView{
  func createPanGestureRecognizerOn(_ obj: AnyObject){
    let pgr = UIPanGestureRecognizer(target: obj, action: #selector(ViewController.panning(_:)))
    addGestureRecognizer(pgr)
  }
}

class ViewController: UIViewController {
  
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
  
  var behaviors: [UIDynamicBehavior]{
    return [self.collision, self.noise]
  }
  
  lazy var squareView: UIView = {
    let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    view.createPanGestureRecognizerOn(self)
    view.backgroundColor = UIColor.brown
    return view
    }()
  
  lazy var pentagonView: PentagonView = {
    let view = PentagonView.pentagonViewWithDiameter(100)
    view.createPanGestureRecognizerOn(self)
    view.backgroundColor = UIColor.clear
    view.center = self.view.center
    return view
    }()
  
  var views: [UIView]{
    return [self.squareView, self.pentagonView]
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(squareView)
    view.addSubview(pentagonView)
    animator.addBehaviors(behaviors)
  }
  
  @IBAction func panning(_ sender: UIPanGestureRecognizer) {
    
    switch sender.state{
    case .began:
      collision.removeItems()
      noise.removeItems()
    case .changed:
      sender.view?.center = sender.location(in: view)
    case .ended, .cancelled:
      collision.addItems(views)
      noise.addItems(views)
    default: ()
    }
    
  }
  
}

