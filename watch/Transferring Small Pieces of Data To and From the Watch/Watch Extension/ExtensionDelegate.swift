//
//  ExtensionDelegate.swift
//  Watch Extension
//
//  Created by Vandad on 8/5/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import WatchKit
import WatchConnectivity

struct Person{
  let name: String
  let age: Int
}

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
    didReceiveApplicationContext applicationContext: [String : Any]) {
      
      guard let people = applicationContext["people"] as?
        Array<[String : AnyObject]> , people.count > 0 else{
          status = "Did not find the people array"
        return
      }
      
      var persons = [Person]()
      for p in people where p["name"] is String && p["age"] is Int{
        let person = Person(name: p["name"] as! String, age: p["age"] as! Int)
        persons.append(person)
      }
      
      status = "Received \(persons.count) people from the iOS app"
    
  }
  
  func applicationDidFinishLaunching() {

    guard WCSession.isSupported() else{
      return
    }
    
    let session = WCSession.default()
    session.delegate = self
    session.activate()
    
  }
  
}
