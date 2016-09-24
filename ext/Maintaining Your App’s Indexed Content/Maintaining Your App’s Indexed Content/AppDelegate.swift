//
//  AppDelegate.swift
//  Maintaining Your App’s Indexed Content
//
//  Created by Vandad on 7/1/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import UIKit
import SharedCode

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    Indexer().doIndex()
    
    return true
  }
}

