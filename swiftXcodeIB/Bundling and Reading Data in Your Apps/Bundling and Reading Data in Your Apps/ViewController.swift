//
//  ViewController.swift
//  Bundling and Reading Data in Your Apps
//
//  Created by Vandad on 8/14/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet var lbl: UILabel!
  
  var status = ""{
    didSet{lbl.text = status}
  }
  
  func example1(){
    
    guard let asset = NSDataAsset(name: "rtf") else {
      status = "Could not find the data"
      return
    }
    
    let options = [
      NSDocumentTypeDocumentAttribute : NSRTFTextDocumentType as AnyObject,
      NSCharacterEncodingDocumentAttribute : String.Encoding.utf8 as AnyObject
      ] as [String : AnyObject]
    
    do{
      let str = try NSAttributedString(data: asset.data, options: options,
        documentAttributes: nil)
      lbl.attributedText = str
    } catch let err{
      status = "Error = \(err)"
    }
    
    
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    example1()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
}

