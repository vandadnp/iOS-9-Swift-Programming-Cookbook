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
  let processInfo = ProcessInfo.processInfo
  
  func powerModeChanged(_ notif: Notification){
    
    guard mustDownloadVideo else{
      return
    }
    
    downloadNow()
    
  }
  
  func downloadNow(){
    
    guard let url = URL(string: "http://localhost:8888/video.mp4") ,
      !processInfo.isLowPowerModeEnabled else{
      return
    }
    
    //do the download here
    print(url)
    
    mustDownloadVideo = false
    
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    
    NotificationCenter.default.addObserver(self,
      selector: #selector(ViewController.powerModeChanged(_:)),
      name: NSNotification.Name.NSProcessInfoPowerStateDidChange, object: nil)
    
    downloadNow()
    
  }


}

