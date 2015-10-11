//
//  ViewController.swift
//  Communicating Interactively Between iOS and Watch OS
//
//  Created by Vandad on 8/5/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import UIKit
import WatchConnectivity
import SharedCode

class ViewController: UIViewController, WCSessionDelegate {

  @IBOutlet var sendBtn: UIBarButtonItem!
  @IBOutlet var textField: UITextField!
  @IBOutlet var watchStatusLbl: UILabel!
  @IBOutlet var watchReplyLbl: UILabel!
  
  var watchStatus: String{
    get{return self.watchStatusLbl.text ?? ""}
    set{onMainThread{self.watchStatusLbl.text = newValue}}
  }
  
  var watchReply: String{
    get{return self.watchReplyLbl.text ?? ""}
    set{onMainThread{self.watchReplyLbl.text = newValue}}
  }
  
  @IBAction func send(sender: AnyObject) {
    
    guard let txt = textField.text where txt.characters.count > 0 else{
      textField.placeholder = "Enter some text here first"
      return
    }
    
    WCSession.defaultSession().sendMessage(["msg" : txt],
      replyHandler: {dict in
      
        guard dict["msg"] is String &&
          dict["msg"] as! String == "delivered" else{
          self.watchReply = "Could not deliver the message"
          return
        }
        
        self.watchReply = dict["msg"] as! String
        
    }){err in
      self.watchReply = "An error happened in sending the message"
    }
    
  }
  
  func session(session: WCSession,
    didReceiveMessage message: [String : AnyObject]) {
      
      guard let msg = message["msg"] as? Int,
        let value = PredefinedMessage(rawValue: msg) else{
          watchReply = "Received invalid message"
        return
      }
      
      switch value{
      case .Hello:
        watchReply = "Hello"
      case .HowAreYou:
        watchReply = "How are you?"
      case .IHearYou:
        watchReply = "I hear you"
      case .ThankYou:
        watchReply = "Thank you"
      }
      
  }
  
  func updateUiForSession(session: WCSession){
    watchStatus = session.reachable ? "Reachable" : "Not reachable"
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

