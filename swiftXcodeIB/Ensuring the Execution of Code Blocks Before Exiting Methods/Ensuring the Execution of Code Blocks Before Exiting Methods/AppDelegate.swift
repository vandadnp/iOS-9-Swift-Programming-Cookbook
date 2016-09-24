//
//  AppDelegate.swift
//  Ensuring the Execution of Code Blocks Before Exiting Methods
//
//  Created by Vandad on 6/25/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  
  enum Errors : Error{
    case emptyString
  }
  
  func imageForString(_ str: String, size: CGSize) throws -> UIImage{
    
    defer{
      UIGraphicsEndImageContext()
    }
    
    UIGraphicsBeginImageContextWithOptions(size, true, 0)
    
    if str.characters.count == 0{
      throw Errors.emptyString
    }
    
    //draw the string here...
    
    return UIGraphicsGetImageFromCurrentImageContext()!
    
  }

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    do{
      let i = try imageForString("Foo", size: CGSize(width: 100, height: 50))
      print(i)
    } catch let excep{
      print(excep)
    }
    
    
    
    return true
  }
}

