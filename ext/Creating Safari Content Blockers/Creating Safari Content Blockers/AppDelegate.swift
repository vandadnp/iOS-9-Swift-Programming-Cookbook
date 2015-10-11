//
//  AppDelegate.swift
//  Creating Safari Content Blockers
//
//  Created by Vandad on 6/30/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import UIKit
import SafariServices

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(application: UIApplication,
    didFinishLaunchingWithOptions
    launchOptions: [NSObject: AnyObject]?) -> Bool {
    return true
  }

  func applicationDidBecomeActive(application: UIApplication) {
    
    //TODO: replace this with your own content blocker's identifier
    let id = "se.pixolity.Creating-Safari-Content-Blockers.Image-Blocker"
    SFContentBlockerManager.reloadContentBlockerWithIdentifier(id) {error in
      guard error == nil else {
        //an error happened, handle it
        print("Failed to reload the blocker")
        return
      }
      print("Reloaded the blocker")
    }
  }

}

