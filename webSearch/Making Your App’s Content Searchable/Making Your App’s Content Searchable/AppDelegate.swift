//
//  AppDelegate.swift
//  Making Your App’s Content Searchable
//
//  Created by Vandad on 7/1/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import UIKit
import CoreSpotlight
import SharedCode

extension String{
  func toFoundationString() -> NSString{
    return NSString(string: self)
  }
}


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(application: UIApplication,
    continueUserActivity userActivity: NSUserActivity,
    restorationHandler: ([AnyObject]?) -> Void) -> Bool {
      
      guard userActivity.activityType == CSSearchableItemActionType,
      let userInfo = userActivity.userInfo,
      let id = userInfo[CSSearchableItemActivityIdentifier
        .toFoundationString()] as? String
      else{
          return false
      }
      
      //now we have access to id of the activity. and that is the URL
      print(id)
      
      return true
    
  }
  
  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    
    Indexer().doIndex()
    
    return true
  }
}

