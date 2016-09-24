//
//  AppDelegate.swift
//  Binding Keychain Items to Passcode and Touch ID
//
//  Created by Vandad on 7/30/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import UIKit
import Security
import SharedCode

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  
  func example1(){
    
    guard let flags =
      SecAccessControlCreateWithFlags(kCFAllocatorDefault,
        kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly,
        SecAccessControlCreateFlags.touchIDAny, nil) else{
          print("Could not create the access control flags")
          return
    }
    
    let password = "some string"
    
    guard let data = password.data(using: String.Encoding.utf8) else{
      print("Could not get data from string")
      return
    }
    
    let service = "onlinePasswords"
    
    let attrs = [
      kSecClass.str() : kSecClassGenericPassword.str(),
      kSecAttrService.str() : service,
      kSecValueData.str() : data,
      kSecUseAuthenticationUI.str() : kSecUseAuthenticationUIAllow.str(),
      kSecAttrAccessControl.str() : flags,
    ] as [String : Any]
    
    OperationQueue().addOperation{
      guard SecItemAdd(attrs as CFDictionary, nil) == errSecSuccess else{
        print("Could not add the item to the keychain")
        return
      }
      
      print("Successfully added the item to keychain")
    }
    
  }
  
  

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
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

