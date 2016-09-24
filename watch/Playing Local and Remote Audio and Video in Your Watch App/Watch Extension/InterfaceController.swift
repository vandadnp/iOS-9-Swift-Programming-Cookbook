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
      DispatchQueue.main.async{
        self.statusLbl.setText(newValue)
      }
    }
  }
  
  @IBAction func play() {
    
    guard let url = URL(string: "http://localhost:8888/video.mp4") else{
      status = "Could not create url"
      return
    }
    
    let gravity = WKVideoGravity.resizeAspectFill.rawValue
    
    let options = [
      WKMediaPlayerControllerOptionsAutoplayKey : NSNumber(value: true as Bool),
      WKMediaPlayerControllerOptionsStartTimeKey : 4.0 as TimeInterval,
      WKMediaPlayerControllerOptionsVideoGravityKey : gravity,
      WKMediaPlayerControllerOptionsLoopsKey : NSNumber(value: true as Bool),
    ] as [String : Any]
    
    presentMediaPlayerController(with: url, options: options) {
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
