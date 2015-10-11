//
//  AppDelegate.swift
//  Noticing Changes in Pairing State Between the iOS and Watch Apps
//
//  Created by Vandad on 8/4/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import UIKit
import WatchConnectivity

extension WCSession{
  public func printInfo(){
    
    //paired
    print("Paired: ", terminator: "")
    print(self.paired ? "Yes" : "No")
    
    //watch app installed
    print("Watch app installed: ", terminator: "")
    print(self.watchAppInstalled ? "Yes" : "No")
    
    //complication enabled
    print("Complication enabled: ", terminator: "")
    print(self.complicationEnabled ? "Yes" : "No")
    
    //watch directory
    print("Watch directory url", terminator: "")
    print(self.watchDirectoryURL)
    
  }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, WCSessionDelegate {

  var window: UIWindow?
  
  func sessionReachabilityDidChange(session: WCSession) {
    print("Reachable: ",  terminator: "")
    print(session.reachable ? "Yes" : "No")
  }
  
  func sessionWatchStateDidChange(session: WCSession) {
    print("Watch state is changed")
    session.printInfo()
  }

  func example1(){
    guard WCSession.isSupported() else {
      print("Session is not supported")
      return
    }
    
    let session = WCSession.defaultSession()
    session.delegate = self
    session.activateSession()
  }

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    // Override point for customization after application launch.
    example1()
    return true
  }
  
}

