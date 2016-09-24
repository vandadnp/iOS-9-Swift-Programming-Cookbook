//
//  ViewController.swift
//  Categorizing and Downloading Assets to get Smaller Binaries
//
//  Created by Vandad on 6/25/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet var img1: UIImageView!
  @IBOutlet var img2: UIImageView!
  @IBOutlet var img3: UIImageView!
  
  var imageViews: [UIImageView]{
    return [self.img1, self.img2, self.img3]
  }
  
  var currentResourcePack: NSBundleResourceRequest?
  
  func displayImagesForResourceTag(_ tag: String){
    OperationQueue.main.addOperation{
      for n in 0..<self.imageViews.count{
        self.imageViews[n].image = UIImage(named: tag + "-\(n+1)")
      }
    }
  }
  
  func useLevel(_ lvl: UInt32){
    
    let imageViews = [img1, img2, img3]
    
    for img in imageViews{
      img?.image = nil
    }
    
    let tag = "level\(lvl)"
    
    if let req = currentResourcePack{
      req.endAccessingResources()
    }
    
    currentResourcePack = NSBundleResourceRequest(tags: [tag])
    
    guard let req = currentResourcePack else {
      return
    }
    
    req.conditionallyBeginAccessingResources{available in
      if available{
        self.displayImagesForResourceTag(tag)
      } else {
        req.beginAccessingResources{error in
          guard error == nil else{
            //TODO: you can handle the error here
            return
          }
          self.displayImagesForResourceTag(tag)
        }
      }
      
    }
    
  }
  
  @IBAction func useLevel3(_ sender: AnyObject) {
    useLevel(3)
  }
  
  @IBAction func useLevel2(_ sender: AnyObject) {
    useLevel(2)
  }

  @IBAction func useLevel1(_ sender: AnyObject) {
    useLevel(1)
  }

}

