//
//  ViewController.swift
//  Transferring Dictionaries in Queues To and From the Watch
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
  
  @IBAction func send() {
    
    guard let infoPlist = NSBundle.mainBundle().infoDictionary else{
      status = "Could not get the Info.plist"
      return
    }
    
    let key = kCFBundleIdentifierKey as String
    
    let plist = [
      key : infoPlist[key] as! String
    ]
    
    let transfer = WCSession.defaultSession().transferUserInfo(plist)
    status = transfer.transferring ? "Sent" : "Could not send yet"
    
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

