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

  func stringFromData(_ data: Data?) -> String?{
    
    guard let data = data,
      let str = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
      , data.count > 0 else{
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
    
    guard let data = "Foo".data(using: .utf8),
      data.count > 0 else{
        return
    }
    
    if let str = stringFromData(data){
      print("Got the string \(str)")
    } else {
      print("No string came back")
    }
    
  }
  
  func example3(firstName: String?, lastName: String?, age: UInt8?){
    
    guard let firstName = firstName, let lastName = lastName , let _ = age ,
      firstName.characters.count > 0 && lastName.characters.count > 0 else{
        return
    }
    
    print(firstName, " ", lastName)
    
  }

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    example1()
    example2()
    example3(firstName: "Food", lastName: "Bar", age: 30)

    return true
  }

}

