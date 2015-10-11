//
//  AppDelegate.swift
//  Looping Conditionally Through a Collection
//
//  Created by Vandad on 7/4/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  
  func example1(){
    
    let dic = [
      "name" : "Foo",
      "lastName" : "Bar",
      "age" : 30,
      "sex" : 1,
    ]
    
    for (k, v) in dic where v is Int{
      print("The key \(k) contains an integer value of \(v)")
    }
    
  }
  
  func example2(){
    
    let nums = 0..<1000
    let divisibleBy8 = {$0 % 8 == 0}
    for n in nums where divisibleBy8(n){
      print("\(n) is divisible by 8")
    }
    
  }
  
  func example3(){
    
    let dic = [
      "name" : "Foo",
      "lastName" : "Bar",
      "age" : 30,
      "sex" : 1,
    ]
    
    for (k, v) in dic where v is Int && v as! Int > 10{
      print("The key \(k) contains the value of \(v) that is larger than 10")
    }
    
  }
  
  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

    example1()
    example2()
    example3()
    
    return true
  }

}

