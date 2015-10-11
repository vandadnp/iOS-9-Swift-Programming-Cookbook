//
//  ExtensionDelegate.swift
//  Watch Extension
//
//  Created by Vandad on 8/5/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import WatchKit
import WatchConnectivity

class ExtensionDelegate: NSObject, WKExtensionDelegate, WCSessionDelegate{
  
  var status = ""{
    didSet{
      dispatch_async(dispatch_get_main_queue()){
        guard let interface =
          WKExtension.sharedExtension().rootInterfaceController as?
          InterfaceController else{
            return
        }
        interface.status = self.status
      }
    }
  }
  
  func session(session: WCSession,
    didReceiveUserInfo userInfo: [String : AnyObject]) {
    
      guard let bundleVersion = userInfo[kCFBundleIdentifierKey as String]
        as? String else{
        status = "Could not read the bundle version"
        return
      }
      
      status = bundleVersion
      
  }
  
  func applicationDidFinishLaunching() {
    
    guard WCSession.isSupported() else{
      status = "Sessions are not supported"
      return
    }
    
    let session = WCSession.defaultSession()
    session.delegate = self
    session.activateSession()
    
  }
  
}
