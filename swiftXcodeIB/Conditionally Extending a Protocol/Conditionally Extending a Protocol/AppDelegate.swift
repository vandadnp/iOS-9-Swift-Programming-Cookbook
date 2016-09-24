//
//  AppDelegate.swift
//  Conditionally Extending a Protocol
//
//  Created by Vandad on 6/26/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import UIKit

extension Sequence where
  Iterator.Element : IntegerArithmetic{
  public func canFind(_ value: Iterator.Element) -> Bool{
    for (_, v) in self.enumerated(){
      if v == value{
        return true
      }
    }
    return false
  }
}

extension Sequence where Iterator.Element : FloatingPoint{
  //write your code here
  func doSomething(){
    //TODO: code this
  }
}

extension Sequence where Iterator.Element : ExpressibleByStringLiteral{
  func longestString() -> String{
    var s = ""
    for (_, v) in self.enumerated(){
      if let temp = v as? String
        , temp.characters.count > s.characters.count{
          s = temp
      }
    }
    return s
  }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  
  func example1(){
    
    if [1, 3, 5, 7].canFind(5){
      print("Found it")
    } else {
      print("Could not find it")
    }
    
  }

  func example2(){
    
    [1.1, 2.2, 3.3].doSomething()
    
  }
  
  func example3(){
    
    print(["Foo", "Bar", "Vandad"].longestString())
    
  }
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    
    example1()
    example2()
    example3()
    
    return true
  }
}

