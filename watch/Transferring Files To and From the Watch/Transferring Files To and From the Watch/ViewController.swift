//
//  ViewController.swift
//  Transferring Files To and From the Watch
//
//  Created by Vandad on 8/5/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import UIKit
import WatchConnectivity

class ViewController: UIViewController, WCSessionDelegate {
  
  @IBOutlet var statusLbl: UILabel!
  @IBOutlet var sendBtn: UIButton!
  
  var status: String?{
    get{return self.statusLbl.text}
    set{
      dispatch_async(dispatch_get_main_queue()){
        self.statusLbl.text = newValue
      }
    }
  }
  
  func session(session: WCSession,
    didFinishFileTransfer fileTransfer: WCSessionFileTransfer,
    error: NSError?) {
    
      guard error == nil else{
        status = "Error in transferring"
        return
      }
      
      status = "Successfully sent the file"
      
  }
  
  @IBAction func send() {
    
    let fileName = "file.txt"
    
    let fm = NSFileManager()
    
    let url = try! fm.URLForDirectory(.CachesDirectory,
      inDomain: .UserDomainMask, appropriateForURL: nil,
      create: true).URLByAppendingPathComponent(fileName)
    
    let text = "Foo Bar"
    
    do{
      try text.writeToURL(url, atomically: true,
        encoding: NSUTF8StringEncoding)
    } catch {
      status = "Could not write the file"
      return
    }
    
    let metadata = ["fileName" : fileName]
    WCSession.defaultSession().transferFile(url, metadata: metadata)
    
  }
  
  func updateUiForSession(session: WCSession){
    status = session.reachable ? "Ready to send" : "Not reachable"
    sendBtn.enabled = session.reachable
  }
  
  func sessionReachabilityDidChange(session: WCSession) {
    updateUiForSession(session)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    guard WCSession.isSupported() else{
      return
    }
    
    let session = WCSession.defaultSession()
    session.delegate = self
    session.activateSession()
    updateUiForSession(session)
    
  }
  
}

