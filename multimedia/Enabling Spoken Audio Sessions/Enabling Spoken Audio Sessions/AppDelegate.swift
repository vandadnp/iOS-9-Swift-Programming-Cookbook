//
//  AppDelegate.swift
//  Enabling Spoken Audio Sessions
//
//  Created by Vandad on 8/12/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import UIKit
import AVFoundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  //detects if the Spoken-Audio mode is available or not
  func example1(){
    
    let session = AVAudioSession.sharedInstance()
    
    guard session.availableCategories.filter(
      {$0 == AVAudioSessionCategoryPlayback}).count == 1 &&
      session.availableModes.filter(
        {$0 == AVAudioSessionModeSpokenAudio}).count == 1 else{
      print("Could not find the category or the mode")
      return
    }
    
    do{
      try session.setCategory(AVAudioSessionCategoryPlayback,
        withOptions:
        AVAudioSessionCategoryOptions.InterruptSpokenAudioAndMixWithOthers)
      
      try session.setMode(AVAudioSessionModeSpokenAudio)
      
      try session.setActive(true, withOptions:
        AVAudioSessionSetActiveOptions.NotifyOthersOnDeactivation)
      
    } catch let err{
      print("Error = \(err)")
    }
    
  }

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    // Override point for customization after application launch.
    
    example1()
    
    return true
  }

  func applicationWillResignActive(application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
  }

  func applicationDidEnterBackground(application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }

  func applicationWillEnterForeground(application: UIApplication) {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
  }

  func applicationDidBecomeActive(application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }

  func applicationWillTerminate(application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }


}

