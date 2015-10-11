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
    enterInfo.behavior = .TextInput //this is the key to this example
    enterInfo.activationMode = .Foreground
    
    let cancel = UIMutableUserNotificationAction()
    cancel.identifier = "cancel"
    cancel.title = "Cancel"
    
    let category = UIMutableUserNotificationCategory()
    category.identifier = "texted"
    category.setActions([enterInfo, cancel], forContext: .Default)
    
    let settings = UIUserNotificationSettings(
      forTypes: .Alert, categories: [category])
    
    UIApplication.sharedApplication()
      .registerUserNotificationSettings(settings)
    
  }
  
  func application(application: UIApplication,
    didFinishLaunchingWithOptions
    launchOptions: [NSObject : AnyObject]?) -> Bool {
      
      registerForNotifications()
      
      return true
  }
  
  func scheduleNotification(){
    
    let n = UILocalNotification()
    let c = NSCalendar.autoupdatingCurrentCalendar()
    let comp = c.componentsInTimeZone(c.timeZone, fromDate: NSDate())
    comp.second += 3
    let date = c.dateFromComponents(comp)
    n.fireDate = date
    
    n.alertBody = "Please enter your name now"
    n.alertAction = "Enter"
    n.category = "texted"
    UIApplication.sharedApplication().scheduleLocalNotification(n)
    
  }
  
  func applicationDidEnterBackground(application: UIApplication) {
    scheduleNotification()
  }
  
  func application(application: UIApplication,
    handleActionWithIdentifier identifier: String?,
    forLocalNotification notification: UILocalNotification,
    withResponseInfo responseInfo: [NSObject : AnyObject],
    completionHandler: () -> Void) {
      
      if let text = responseInfo[UIUserNotificationActionResponseTypedTextKey]
        as? String{
          
          print(text)
          //TODO: now you have access to this text
          
      }
      
      completionHandler()
      
  }
  
}
