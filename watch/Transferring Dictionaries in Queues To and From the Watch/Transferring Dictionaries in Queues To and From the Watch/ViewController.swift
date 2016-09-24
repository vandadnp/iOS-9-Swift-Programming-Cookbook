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
  /** Called when all delegate callbacks for the previously selected watch has occurred. The session can be re-activated for the now selected watch using activateSession. */
  @available(iOS 9.3, *)
  public func sessionDidDeactivate(_ session: WCSession) {
    
  }
  
  /** Called when the session can no longer be used to modify or add any new transfers and, all interactive messages will be cancelled, but delegate callbacks for background transfers can still occur. This will happen when the selected watch is being changed. */
  @available(iOS 9.3, *)
  public func sessionDidBecomeInactive(_ session: WCSession) {
    
  }

  /** Called when the session has completed activation. If session state is WCSessionActivationStateNotActivated there will be an error with more details. */
  @available(iOS 9.3, *)
  public func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    
  }
  
  

  
  @IBOutlet var statusLbl: UILabel!
  @IBOutlet var sendBtn: UIButton!
  
  var status: String?{
    get{return self.statusLbl.text}
    set{
      DispatchQueue.main.async{
        self.statusLbl.text = newValue
      }
    }
  }
  
  @IBAction func send() {
    
    guard let infoPlist = Bundle.main.infoDictionary else{
      status = "Could not get the Info.plist"
      return
    }
    
    let key = kCFBundleIdentifierKey as String
    
    let plist = [
      key : infoPlist[key] as! String
    ]
    
    let transfer = WCSession.default().transferUserInfo(plist)
    status = transfer.isTransferring ? "Sent" : "Could not send yet"
    
  }
  
  func updateUiForSession(_ session: WCSession){
    status = session.isReachable ? "Ready to send" : "Not reachable"
    sendBtn.isEnabled = session.isReachable
  }

  func sessionReachabilityDidChange(_ session: WCSession) {
    updateUiForSession(session)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    guard WCSession.isSupported() else{
      return
    }
    
    let session = WCSession.default()
    session.delegate = self
    session.activate()
    updateUiForSession(session)
    
  }

}

