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

  func application(_ application: UIApplication,
    didFinishLaunchingWithOptions
    launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    return true
  }

  func applicationDidBecomeActive(_ application: UIApplication) {
    
    //TODO: replace this with your own content blocker's identifier
    let id = "se.pixolity.Creating-Safari-Content-Blockers.Image-Blocker"
    SFContentBlockerManager.reloadContentBlocker(withIdentifier: id) {error in
      guard error == nil else {
        //an error happened, handle it
        print("Failed to reload the blocker")
        return
      }
      print("Reloaded the blocker")
    }
  }

}

