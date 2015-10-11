//
//  AppDelegate.swift
//  Deleting Your App’s Searchable content
//
//  Created by Vandad on 7/2/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import UIKit
import CoreSpotlight

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  
  func example1(){
    
    let identifiers = [
      "com.yourcompany.etc1",
      "com.yourcompany.etc2",
      "com.yourcompany.etc3"
    ]
    
    let i = CSSearchableIndex(name: NSBundle.mainBundle().bundleIdentifier!)
    
    i.fetchLastClientStateWithCompletionHandler {clientState, err in
      guard err == nil else{
        print("Could not fetch last client state")
        return
      }
      
      let state: NSData
      if let s = clientState{
        state = s
      } else {
        state = NSData()
      }
      
      i.beginIndexBatch()
      
      i.deleteSearchableItemsWithIdentifiers(identifiers) {err in
        if let e = err{
          print("Error happened \(e)")
        } else {
          print("Successfully deleted the given identifiers")
        }
      }
      i.endIndexBatchWithClientState(state, completionHandler: {err in
        guard err == nil else{
          print("Error happened in ending batch updates = \(err!)")
          return
        }
        print("Successfully batch updated the index")
      })
      
    }
    
    
  }

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    example1()
    return true
  }
  
}

