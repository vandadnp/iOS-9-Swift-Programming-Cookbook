//
//  AppDelegate.swift
//  Checking for API Availability
//
//  Created by Vandad on 6/25/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  
  enum Errors : ErrorType{
    case EmptyData
  }
  
  func bytesFromData(data: NSData) throws -> [UInt8]{
    
    if (data.length == 0){
      throw Errors.EmptyData
    }
    
    var buffer = [UInt8](count: data.length, repeatedValue: 0)
    
    if #available(iOS 8.1, *){
      data.getBytes(&buffer, length: data.length)
    } else {
      data.getBytes(&buffer)
    }
    
    return buffer
    
  }
  
  func example1(){
    
    guard let data = "Foo".dataUsingEncoding(NSUTF8StringEncoding) else {
      return
    }
    
    do{
      let bytes = try bytesFromData(data)
      print("Data = \(bytes)")
    } catch {
      print("Failed to get bytes")
    }
    
    
  }

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    
    example1()
    
    return true
  }

}

