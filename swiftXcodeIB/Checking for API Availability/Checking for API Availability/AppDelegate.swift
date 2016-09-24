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
  
  enum Errors : Error{
    case emptyData
  }
  
  func bytesFromData(_ data: Data) throws -> [UInt8]{
    
    if (data.count == 0){
      throw Errors.emptyData
    }
    
    var buffer = [UInt8](repeating: 0, count: data.count)
    
    if #available(iOS 8.1, *){
      (data as NSData).getBytes(&buffer, length: data.count)
    } else {
      (data as NSData).getBytes(&buffer)
    }
    
    return buffer
    
  }
  
  func example1(){
    
    guard let data = "Foo".data(using: String.Encoding.utf8) else {
      return
    }
    
    do{
      let bytes = try bytesFromData(data)
      print("Data = \(bytes)")
    } catch {
      print("Failed to get bytes")
    }
    
    
  }

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    example1()
    
    return true
  }

}

