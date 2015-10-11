//
//  ViewController.swift
//  Handling Low Power Mode and Providing Alternatives
//
//  Created by Vandad on 8/12/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  var mustDownloadVideo = true
  let processInfo = NSProcessInfo.processInfo()
  
  func powerModeChanged(notif: NSNotification){
    
    guard mustDownloadVideo else{
      return
    }
    
    downloadNow()
    
  }
  
  func downloadNow(){
    
    guard let url = NSURL(string: "http://localhost:8888/video.mp4") where
      !processInfo.lowPowerModeEnabled else{
      return
    }
    
    //do the download here
    print(url)
    
    mustDownloadVideo = false
    
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    
    NSNotificationCenter.defaultCenter().addObserver(self,
      selector: "powerModeChanged:",
      name: NSProcessInfoPowerStateDidChangeNotification, object: nil)
    
    downloadNow()
    
  }


}

