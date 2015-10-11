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
  
  var isReachable = false{
    willSet{
      self.rootController?.repliesGroup.setHidden(!newValue)
    }
  }
  
  var rootController: InterfaceController?{
    get{
      guard let interface =
        WKExtension.sharedExtension().rootInterfaceController as?
        InterfaceController else{
          return nil
      }
      return interface
    }
  }
  
  var iosAppReply = ""{
    didSet{
      dispatch_async(dispatch_get_main_queue()){
        self.rootController?.iosAppReplyLbl.setText(self.iosAppReply)
      }
    }
  }
  
  func session(session: WCSession,
    didReceiveMessage message: [String : AnyObject],
    replyHandler: ([String : AnyObject]) -> Void) {
      
      guard message["msg"] is String else{
        replyHandler(["msg" : "failed"])
        return
      }
      
      iosAppReply = message["msg"] as! String
      replyHandler(["msg" : "delivered"])
    
  }
  
  func sessionReachabilityDidChange(session: WCSession) {
    isReachable = session.reachable
  }
  
  func applicationDidFinishLaunching() {
    
    guard WCSession.isSupported() else{
      iosAppReply = "Sessions are not supported"
      return
    }
    
    let session = WCSession.defaultSession()
    session.delegate = self
    session.activateSession()
    isReachable = session.reachable
    
  }
  
}
