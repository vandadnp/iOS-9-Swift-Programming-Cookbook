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
    print(self.isPaired ? "Yes" : "No")
    
    //watch app installed
    print("Watch app installed: ", terminator: "")
    print(self.isWatchAppInstalled ? "Yes" : "No")
    
    //complication enabled
    print("Complication enabled: ", terminator: "")
    print(self.isComplicationEnabled ? "Yes" : "No")
    
    //watch directory
    print("Watch directory url", terminator: "")
    print(self.watchDirectoryURL)
    
  }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, WCSessionDelegate {
  
  /** Called when all delegate callbacks for the previously selected watch has occurred. The session can be re-activated for the now selected watch using activateSession. */
  @available(iOS 9.3, *)
  public func sessionDidDeactivate(_ session: WCSession) {
    
  }

  
  /** Called when the session can no longer be used to modify or add any new transfers and, all interactive messages will be cancelled, but delegate callbacks for background transfers can still occur. This will happen when the selected watch is being changed. */
  @available(iOS 9.3, *)
  public func sessionDidBecomeInactive(_ session: WCSession) {
    
  }

  /** Called when the session has completed activation. If session state is WCSessionActivationStateNotActivated there will be an error with more details. */
  @available(iOS 9.3, *)
  public func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    
  }
  
  


  var window: UIWindow?
  
  func sessionReachabilityDidChange(_ session: WCSession) {
    print("Reachable: ",  terminator: "")
    print(session.isReachable ? "Yes" : "No")
  }
  
  func sessionWatchStateDidChange(_ session: WCSession) {
    print("Watch state is changed")
    session.printInfo()
  }

  func example1(){
    guard WCSession.isSupported() else {
      print("Session is not supported")
      return
    }
    
    let session = WCSession.default()
    session.delegate = self
    session.activate()
  }

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    example1()
    return true
  }
  
}

