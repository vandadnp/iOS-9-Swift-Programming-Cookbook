//
//  ExtensionDelegate.swift
//  Watch Extension
//
//  Created by Vandad on 8/4/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import WatchKit
import WatchConnectivity

class ExtensionDelegate: NSObject, WKExtensionDelegate, WCSessionDelegate {
  
  func sessionReachabilityDidChange(session: WCSession) {
    print("Reachablity changed. Reachable?", terminator: "")
    print(session.reachable ? "Yes" : "No")
  }
  
  func example1(){
    guard WCSession.isSupported() else {
      print("Session is not supported")
      return
    }
    
    let session = WCSession.defaultSession()
    session.delegate = self
    session.activateSession()
  }
  
  func applicationDidFinishLaunching() {
    example1()
  }
  
}
