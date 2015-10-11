//
//  InterfaceController.swift
//  Watch Extension
//
//  Created by Vandad on 8/12/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import WatchKit
import Foundation

class InterfaceController: WKInterfaceController {
  
  @IBOutlet var statusLbl: WKInterfaceLabel!
  
  var status = ""{
    willSet{
      dispatch_async(dispatch_get_main_queue()){
        self.statusLbl.setText(newValue)
      }
    }
  }
  
  @IBAction func play() {
    
    guard let url = NSURL(string: "http://localhost:8888/video.mp4") else{
      status = "Could not create url"
      return
    }
    
    let gravity = WKVideoGravity.ResizeAspectFill.rawValue
    
    let options = [
      WKMediaPlayerControllerOptionsAutoplayKey : NSNumber(bool: true),
      WKMediaPlayerControllerOptionsStartTimeKey : 4.0 as NSTimeInterval,
      WKMediaPlayerControllerOptionsVideoGravityKey : gravity,
      WKMediaPlayerControllerOptionsLoopsKey : NSNumber(bool: true),
    ]
    
    presentMediaPlayerControllerWithURL(url, options: options) {
      didPlayToEnd, endTime, error in
      
      self.dismissMediaPlayerController()
      
      guard error == nil else{
        self.status = "Error occurred \(error)"
        return
      }
      
      if didPlayToEnd{
        self.status = "Played to end of the file"
      } else {
        self.status = "Did not play to end of file. End time = \(endTime)"
      }
      
    }
    
  }
  
}
