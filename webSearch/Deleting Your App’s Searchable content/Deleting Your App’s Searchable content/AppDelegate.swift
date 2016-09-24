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
    
    let i = CSSearchableIndex(name: Bundle.main.bundleIdentifier!)
    
    i.fetchLastClientState {clientState, err in
      guard err == nil else{
        print("Could not fetch last client state")
        return
      }
      
      let state: Data
      if let s = clientState{
        state = s
      } else {
        state = Data()
      }
      
      i.beginBatch()
      
      i.deleteSearchableItems(withIdentifiers: identifiers) {err in
        if let e = err{
          print("Error happened \(e)")
        } else {
          print("Successfully deleted the given identifiers")
        }
      }
      i.endBatch(withClientState: state, completionHandler: {err in
        guard err == nil else{
          print("Error happened in ending batch updates = \(err!)")
          return
        }
        print("Successfully batch updated the index")
      })
      
    }
    
    
  }

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    example1()
    return true
  }
  
}

