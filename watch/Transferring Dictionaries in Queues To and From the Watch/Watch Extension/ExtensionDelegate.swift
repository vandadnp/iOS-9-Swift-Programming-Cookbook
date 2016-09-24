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
  
  /** Called when the session has completed activation. If session state is WCSessionActivationStateNotActivated there will be an error with more details. */
  @available(watchOS 2.2, *)
  public func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    
  }

  
  var status = ""{
    didSet{
      DispatchQueue.main.async{
        guard let interface =
          WKExtension.shared().rootInterfaceController as?
          InterfaceController else{
            return
        }
        interface.status = self.status
      }
    }
  }
  
  func session(_ session: WCSession,
    didReceiveUserInfo userInfo: [String : Any]) {
    
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
    
    let session = WCSession.default()
    session.delegate = self
    session.activate()
    
  }
  
}
