//
//  AppDelegate.swift
//  Recording and Reading Accelerometer Data
//
//  Created by Vandad on 7/29/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import UIKit
import CoreMotion

extension CMSensorDataList : Sequence{
  public func makeIterator() -> NSFastEnumerationIterator {
    return NSFastEnumerationIterator(self)
  }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  lazy var recorder = CMSensorRecorder()
  
  func example1(){
    
    guard CMSensorRecorder.isAccelerometerRecordingAvailable() else {
      print("Accelerometer data recording is not available")
      return
    }
    
    let duration = 3.0
    recorder.recordAccelerometer(forDuration: duration)
    
    OperationQueue().addOperation{[unowned recorder] in
      
      Thread.sleep(forTimeInterval: duration)
      let now = Date()
      let past = now.addingTimeInterval(-(duration))
      guard let data = recorder.accelerometerData(from: past, to: now) else{
        return
      }
      
      for (index, data) in data.enumerated() where data is CMRecordedAccelerometerData{
        guard let data = data as? CMRecordedAccelerometerData else {continue}
        print(index)
        print(data.identifier)
      }
      
    }
    
  }

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

    example1()
    
    return true
  }

  func applicationWillResignActive(_ application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
  }

  func applicationDidEnterBackground(_ application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }

  func applicationWillEnterForeground(_ application: UIApplication) {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
  }

  func applicationDidBecomeActive(_ application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }

  func applicationWillTerminate(_ application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }


}

