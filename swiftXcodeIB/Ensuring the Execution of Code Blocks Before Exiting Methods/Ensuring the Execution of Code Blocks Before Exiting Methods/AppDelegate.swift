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
  
  enum Errors : ErrorType{
    case EmptyString
  }
  
  func imageForString(str: String, size: CGSize) throws -> UIImage{
    
    defer{
      UIGraphicsEndImageContext()
    }
    
    UIGraphicsBeginImageContextWithOptions(size, true, 0)
    
    if str.characters.count == 0{
      throw Errors.EmptyString
    }
    
    //draw the string here...
    
    return UIGraphicsGetImageFromCurrentImageContext()
    
  }

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    
    do{
      let i = try imageForString("Foo", size: CGSize(width: 100, height: 50))
      print(i)
    } catch let excep{
      print(excep)
    }
    
    
    
    return true
  }
}

