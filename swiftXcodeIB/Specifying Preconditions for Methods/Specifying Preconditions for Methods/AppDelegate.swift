//
//  AppDelegate.swift
//  Specifying Preconditions for Methods
//
//  Created by Vandad on 6/25/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func stringFromData(data: NSData?) -> String?{
    
    guard let data = data,
      let str = NSString(data: data, encoding: NSUTF8StringEncoding)
      where data.length > 0 else{
      return nil
    }
    
    return String(str)
    
  }
  
  func example1(){
    
    if let _ = stringFromData(nil){
      print("Got the string")
    } else {
      print("No string came back")
    }
    
  }
  
  func example2(){
    
    guard let data = NSString(string: "Foo")
      .dataUsingEncoding(NSUTF8StringEncoding) where data.length > 0 else{
        return
    }
    
    if let str = stringFromData(data){
      print("Got the string \(str)")
    } else {
      print("No string came back")
    }
    
  }
  
  func example3(firstName firstName: String?, lastName: String?, age: UInt8?){
    
    guard let firstName = firstName, let lastName = lastName , _ = age where
      firstName.characters.count > 0 && lastName.characters.count > 0 else{
        return
    }
    
    print(firstName, " ", lastName)
    
  }

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    
    example1()
    example2()
    example3(firstName: "Food", lastName: "Bar", age: 30)

    return true
  }

}

