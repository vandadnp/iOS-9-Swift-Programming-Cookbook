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
  
  func session(_ session: WCSession, didReceive file: WCSessionFile) {
    
    guard let metadata = file.metadata , metadata["fileName"]
      is String else{
      status = "No metadata came through"
      return
    }

    do{
      let str = try String(NSString(contentsOf: file.fileURL,
        encoding: String.Encoding.utf8.rawValue))
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
    
    let session = WCSession.default()
    session.delegate = self
    session.activate()
    
  }
  
}
