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
  
  func drawForFirstTouchInSet(s: Set<UITouch>, event: UIEvent?){
    
    guard let touch = s.first, event = event,
      allTouches = event.coalescedTouchesForTouch(touch)
      where allTouches.count > 0 else{
        return
    }
    
    points += allTouches.map{$0.locationInView(self)}
    
    setNeedsDisplay()
    
  }
  
  override func touchesBegan(touches: Set<UITouch>,
    withEvent event: UIEvent?) {
      
      points.removeAll()
      drawForFirstTouchInSet(touches, event: event)
      
  }
  
  override func touchesCancelled(touches: Set<UITouch>?,
    withEvent event: UIEvent?) {
      
      points.removeAll()
      setNeedsDisplayInRect(bounds)
      
  }
  
  override func touchesMoved(touches: Set<UITouch>,
    withEvent event: UIEvent?) {
      
      drawForFirstTouchInSet(touches, event: event)
      
  }
  
  override func touchesEnded(touches: Set<UITouch>,
    withEvent event: UIEvent?) {
      
      guard let touch = touches.first, event = event,
        predictedTouches = event.predictedTouchesForTouch(touch)
        where predictedTouches.count > 0 else{
          return
      }
      
      points += predictedTouches.map{$0.locationInView(self)}
      setNeedsDisplay()
      
  }
  
  override func drawRect(rect: CGRect) {
    
    let con = UIGraphicsGetCurrentContext()
    
    //set background color
    CGContextSetFillColorWithColor(con, UIColor.blackColor().CGColor)
    CGContextFillRect(con, rect)
    
    CGContextSetFillColorWithColor(con, UIColor.redColor().CGColor)
    CGContextSetStrokeColorWithColor(con, UIColor.redColor().CGColor)
    
    for point in points{
      
      CGContextMoveToPoint(con, point.x, point.y)
      
      if let last = points.last where point != last{
        let next = points[points.indexOf(point)! + 1]
        CGContextAddLineToPoint(con, next.x, next.y)
      }
      
    }
    
    CGContextStrokePath(con)
    
  }
  
}

class ViewController: UIViewController {
  //empty for now
}

