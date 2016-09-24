//
//  ViewController.swift
//  Improving Touch Rates for Smoother UI Interactions
//
//  Created by Vandad on 7/4/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import UIKit

class MyView : UIView{
  
  var points = [CGPoint]()
  
  func drawForFirstTouchInSet(_ s: Set<UITouch>, event: UIEvent?){
    
    guard let touch = s.first, let event = event,
      let allTouches = event.coalescedTouches(for: touch)
      , allTouches.count > 0 else{
        return
    }
    
    points += allTouches.map{$0.location(in: self)}
    
    setNeedsDisplay()
    
  }
  
  override func touchesBegan(_ touches: Set<UITouch>,
    with event: UIEvent?) {
      
      points.removeAll()
      drawForFirstTouchInSet(touches, event: event)
      
  }
  
  override func touchesCancelled(_ touches: Set<UITouch>,
    with event: UIEvent?) {
      
      points.removeAll()
      setNeedsDisplay(bounds)
      
  }
  
  override func touchesMoved(_ touches: Set<UITouch>,
    with event: UIEvent?) {
      
      drawForFirstTouchInSet(touches, event: event)
      
  }
  
  override func touchesEnded(_ touches: Set<UITouch>,
    with event: UIEvent?) {
      
      guard let touch = touches.first, let event = event,
        let predictedTouches = event.predictedTouches(for: touch)
        , predictedTouches.count > 0 else{
          return
      }
      
      points += predictedTouches.map{$0.location(in: self)}
      setNeedsDisplay()
      
  }
  
  override func draw(_ rect: CGRect) {
    
    let con = UIGraphicsGetCurrentContext()
    
    //set background color
    con?.setFillColor(UIColor.black.cgColor)
    con?.fill(rect)
    
    con?.setFillColor(UIColor.red.cgColor)
    con?.setStrokeColor(UIColor.red.cgColor)
    
    for point in points{
      
      con?.move(to: CGPoint(x: point.x, y: point.y))
      
      if let last = points.last , point != last{
        let next = points[points.index(of: point)! + 1]
        con?.addLine(to: CGPoint(x: next.x, y: next.y))
      }
      
    }
    
    con?.strokePath()
    
  }
  
}

class ViewController: UIViewController {
  //empty for now
}

