//
//  InterfaceController.swift
//  Watch Extension
//
//  Created by Vandad on 8/5/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class InterfaceController: WKInterfaceController {
  
  @IBOutlet var iosAppReplyLbl: WKInterfaceLabel!
  @IBOutlet var repliesGroup: WKInterfaceGroup!
  
  func send(_ int: Int){
    
    WCSession.default().sendMessage(["msg" : int],
      replyHandler: nil, errorHandler: nil)
    
  }
  
  @IBAction func sendHello() {
    send(PredefinedMessage.hello.hashValue)
  }
  
  @IBAction func sendThankYou() {
    send(PredefinedMessage.thankYou.hashValue)
  }
  
  @IBAction func sendHowAreYou() {
    send(PredefinedMessage.howAreYou.hashValue)
  }
  
  @IBAction func sendIHearYou() {
    send(PredefinedMessage.iHearYou.hashValue)
  }
  
  
}
