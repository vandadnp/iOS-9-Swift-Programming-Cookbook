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
  func forEach(f: (Generator.Element) -> Void){
    for item in self{
      f(item)
    }
  }
}

class PentagonView : UIView{
  
  private var diameter: CGFloat = 0.0
  
  class func pentagonViewWithDiameter(diameter: CGFloat) -> PentagonView{
    return PentagonView(diameter: diameter)
  }
  
  init(diameter: CGFloat){
    self.diameter = diameter
    super.init(frame: CGRectMake(0, 0, diameter, diameter))
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  var radius: CGFloat{
    return diameter / 2.0
  }
  
  func pointFromAngle(angle: Double) -> CGPoint{
    
    let x = radius + (radius * cos(CGFloat(angle)))
    let y = radius + (radius * sin(CGFloat(angle)))
    return CGPoint(x: x, y: y)
    
  }
  
  lazy var path: UIBezierPath = {
    let path = UIBezierPath()
    path.moveToPoint(self.pointFromAngle(0))
    
    let oneSlice = (M_PI * 2.0) / 5.0
    let lessOneSlice = (M_PI * 2.0) - oneSlice
    
    oneSlice.stride(through: lessOneSlice, by: oneSlice).forEach{
      path.addLineToPoint(self.pointFromAngle($0))
    }
    
    path.closePath()
    return path
    }()
  
  override func drawRect(rect: CGRect) {
    guard let context = UIGraphicsGetCurrentContext() else{
      return
    }
    UIColor.clearColor().setFill()
    CGContextFillRect(context, rect)
    UIColor.yellowColor().setFill()
    path.fill()
  }
  
  override var collisionBoundsType: UIDynamicItemCollisionBoundsType{
    return UIDynamicItemCollisionBoundsType.Path
  }
  
  override var collisionBoundingPath: UIBezierPath{
    let path = self.path.copy() as! UIBezierPath
    path.applyTransform(CGAffineTransformMakeTranslation(-radius, -radius))
    return path
  }
  
}

extension UIView{
  func createPanGestureRecognizerOn(obj: AnyObject){
    let pgr = UIPanGestureRecognizer(target: obj, action: "panning:")
    addGestureRecognizer(pgr)
  }
}

class ViewController: UIViewController {
  
  lazy var animator: UIDynamicAnimator = {
    let animator = UIDynamicAnimator(referenceView: self.view)
    animator.debugEnabled = true
    return animator
    }()
  
  lazy var collision: UICollisionBehavior = {
    let collision = UICollisionBehavior(items: self.views)
    collision.translatesReferenceBoundsIntoBoundary = true
    return collision
    }()
  
  lazy var noise: UIFieldBehavior = {
    let noise = UIFieldBehavior.noiseFieldWithSmoothness(0.9,
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
    view.backgroundColor = UIColor.brownColor()
    return view
    }()
  
  lazy var pentagonView: PentagonView = {
    let view = PentagonView.pentagonViewWithDiameter(100)
    view.createPanGestureRecognizerOn(self)
    view.backgroundColor = UIColor.clearColor()
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
  
  @IBAction func panning(sender: UIPanGestureRecognizer) {
    
    switch sender.state{
    case .Began:
      collision.removeItems()
      noise.removeItems()
    case .Changed:
      sender.view?.center = sender.locationInView(view)
    case .Ended, .Cancelled:
      collision.addItems(views)
      noise.addItems(views)
    default: ()
    }
    
  }
  
}

