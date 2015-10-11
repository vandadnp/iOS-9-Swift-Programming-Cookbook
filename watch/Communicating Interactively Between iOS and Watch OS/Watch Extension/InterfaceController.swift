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
  
  func send(int: Int){
    
    WCSession.defaultSession().sendMessage(["msg" : int],
      replyHandler: nil, errorHandler: nil)
    
  }
  
  @IBAction func sendHello() {
    send(PredefinedMessage.Hello.hashValue)
  }
  
  @IBAction func sendThankYou() {
    send(PredefinedMessage.ThankYou.hashValue)
  }
  
  @IBAction func sendHowAreYou() {
    send(PredefinedMessage.HowAreYou.hashValue)
  }
  
  @IBAction func sendIHearYou() {
    send(PredefinedMessage.IHearYou.hashValue)
  }
  
  
}
