//
//  AppDelegate.swift
//  Authenticating the User with Touch ID with Timeout
//
//  Created by Vandad on 8/3/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import UIKit
import LocalAuthentication
import Security
import SharedCode

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  
  let context = LAContext()
  let reason = "To unlock previously stored security phrase"
  
  func example1(){
    
    guard let flags =
      SecAccessControlCreateWithFlags(kCFAllocatorDefault,
        kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly,
        SecAccessControlCreateFlags.TouchIDAny, nil) else{
          print("Could not create the access control flags")
          return
    }
    
    context.touchIDAuthenticationAllowableReuseDuration =
    LATouchIDAuthenticationMaximumAllowableReuseDuration
    
    context.evaluateAccessControl(flags,
      operation: LAAccessControlOperation.UseItem,
      localizedReason: reason) {[unowned context] succ, err in
      
        guard succ && err == nil else {
          print("Could not evaluate the access control")
          if let e = err {
            print("Error = \(e)")
          }
          return
        }
        
        print("Successfully evaluated the access control")
        
        let service = "onlinePasswords"
        
        let attrs = [
          kSecClass.str() : kSecClassGenericPassword.str(),
          kSecAttrService.str() : service,
          kSecUseAuthenticationUI.str() : kSecUseAuthenticationUIAllow.str(),
          kSecAttrAccessControl.str() : flags,
          kSecReturnData.str() : kCFBooleanTrue,
          kSecUseAuthenticationContext.str() : context,
        ]
        
        //now attempt to use the attrs with SecItemCopyMatching
        
        print(attrs)
        
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

