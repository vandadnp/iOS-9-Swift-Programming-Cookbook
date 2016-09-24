//
//  AppDelegate.swift
//  Creating Your Own Set Types
//
//  Created by Vandad on 6/26/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  
  struct IphoneModels : OptionSet, CustomDebugStringConvertible{
    
    let rawValue: Int
    init(rawValue: Int){
      self.rawValue = rawValue
    }
    
    static let Six = IphoneModels(rawValue: 0)
    static let SixPlus = IphoneModels(rawValue: 1)
    static let Five = IphoneModels(rawValue: 2)
    static let FiveS = IphoneModels(rawValue: 3)
    
    var debugDescription: String{
      switch self{
      case IphoneModels.Six:
        return "iPhone 6"
      case IphoneModels.SixPlus:
        return "iPhone 6+"
      case IphoneModels.Five:
        return "iPhone 5"
      case IphoneModels.FiveS:
        return "iPhone 5s"
      default:
        return "Unknown iPhone"
      }
    }
    
  }
  
  func example1(){
    
    let myIphones: [IphoneModels] = [.Six, .SixPlus]
    
    if myIphones.contains(.FiveS){
      print("You own an iPhone 5s")
    } else {
      print("You don't seem to have an iPhone 5s but you have these:")
      for i in myIphones{
        print(i)
      }
    }
    
  }

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    
    example1()
    
    return true
  }
}

