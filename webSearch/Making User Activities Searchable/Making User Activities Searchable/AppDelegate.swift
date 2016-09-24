//
//  AppDelegate.swift
//  Making User Activities Searchable
//
//  Created by Vandad on 7/2/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    return true
  }

  func application(_ application: UIApplication, willContinueUserActivityWithType userActivityType: String) -> Bool {
    return true
  }
  
  func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([Any]?) -> Void) -> Bool {
    return true
  }
  

}

