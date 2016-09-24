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
  /** Called when the session has completed activation. If session state is WCSessionActivationStateNotActivated there will be an error with more details. */
  @available(watchOS 2.2, *)
  public func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    
  }

  
  func sessionReachabilityDidChange(_ session: WCSession) {
    print("Reachablity changed. Reachable?", terminator: "")
    print(session.isReachable ? "Yes" : "No")
  }
  
  func example1(){
    guard WCSession.isSupported() else {
      print("Session is not supported")
      return
    }
    
    let session = WCSession.default()
    session.delegate = self
    session.activate()
  }
  
  func applicationDidFinishLaunching() {
    example1()
  }
  
}
