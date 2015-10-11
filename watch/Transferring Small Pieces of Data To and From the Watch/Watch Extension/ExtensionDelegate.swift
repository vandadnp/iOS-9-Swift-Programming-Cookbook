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
  
  func session(session: WCSession,
    didReceiveApplicationContext applicationContext: [String : AnyObject]) {
      
      guard let people = applicationContext["people"] as?
        Array<[String : AnyObject]> where people.count > 0 else{
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
    
    let session = WCSession.defaultSession()
    session.delegate = self
    session.activateSession()
    
  }
  
}
