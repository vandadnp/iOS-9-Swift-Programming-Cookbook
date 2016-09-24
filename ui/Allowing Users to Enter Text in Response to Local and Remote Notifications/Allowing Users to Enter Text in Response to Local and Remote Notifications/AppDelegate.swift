//
//  AppDelegate.swift
//  Allowing Users to Enter Text in Response to Local and Remote Notifications
//
//  Created by Vandad on 6/29/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func registerForNotifications(){
    
    let enterInfo = UIMutableUserNotificationAction()
    enterInfo.identifier = "enter"
    enterInfo.title = "Enter your name"
    enterInfo.behavior = .textInput //this is the key to this example
    enterInfo.activationMode = .foreground
    
    let cancel = UIMutableUserNotificationAction()
    cancel.identifier = "cancel"
    cancel.title = "Cancel"
    
    let category = UIMutableUserNotificationCategory()
    category.identifier = "texted"
    category.setActions([enterInfo, cancel], for: .default)
    
    let settings = UIUserNotificationSettings(
      types: .alert, categories: [category])
    
    UIApplication.shared
      .registerUserNotificationSettings(settings)
    
  }
  
  func application(_ application: UIApplication,
    didFinishLaunchingWithOptions
    launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
      
      registerForNotifications()
      
      return true
  }
  
  func scheduleNotification(){
    
    let n = UILocalNotification()
    let c = Calendar.autoupdatingCurrent
    var comp = c.dateComponents(in: c.timeZone, from: Date())
    
    if let second = comp.second{
      comp.second = second + 1
    }
    
    let date = c.date(from: comp)
    n.fireDate = date
    
    n.alertBody = "Please enter your name now"
    n.alertAction = "Enter"
    n.category = "texted"
    UIApplication.shared.scheduleLocalNotification(n)
    
  }
  
  func applicationDidEnterBackground(_ application: UIApplication) {
    scheduleNotification()
  }
  
  func application(_ application: UIApplication,
    handleActionWithIdentifier identifier: String?,
    for notification: UILocalNotification,
    withResponseInfo responseInfo: [AnyHashable: Any],
    completionHandler: @escaping () -> Void) {
      
      if let text = responseInfo[UIUserNotificationActionResponseTypedTextKey]
        as? String{
          
          print(text)
          //TODO: now you have access to this text
          
      }
      
      completionHandler()
      
  }
  
}
