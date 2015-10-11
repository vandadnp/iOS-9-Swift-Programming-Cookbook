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
  
  func session(session: WCSession, didReceiveFile file: WCSessionFile) {
    
    guard let metadata = file.metadata where metadata["fileName"]
      is String else{
      status = "No metadata came through"
      return
    }

    do{
      let str = try String(NSString(contentsOfURL: file.fileURL,
        encoding: NSUTF8StringEncoding))
      guard str.characters.count > 0 else{
        status = "No file came through"
        return
      }
      status = str
    } catch {
      status = "Could not read the file"
      return
    }
    
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
