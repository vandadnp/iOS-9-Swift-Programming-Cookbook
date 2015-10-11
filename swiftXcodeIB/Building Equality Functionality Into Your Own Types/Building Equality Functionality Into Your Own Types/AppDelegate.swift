//
//  AppDelegate.swift
//  Building Equality Functionality Into Your Own Types
//
//  Created by Vandad on 6/29/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import UIKit

protocol Named{
  var name: String {get}
}

func ==(lhs : Named, rhs: Named) -> Bool{
  return lhs.name == rhs.name
}

struct Car{}
struct Motorcycle{}

extension Car : Named{
  var name: String{
    return "Car"
  }
}

extension Motorcycle : Named{
  var name: String{
    return "Motorcycle"
  }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  
  func example1(){
    
    let v1: Named = Car()
    let v2: Named = Motorcycle()
    
    if v1 == v2{
      print("They are equal")
    } else {
      print("They are not equal")
    }
    
  }
  
  func example2(){
    
    let v1: Named = Car()
    let v2: Named = Car()
    
    if v1 == v2{
      print("They are equal")
    } else {
      print("They are not equal")
    }
    
  }

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    // Override point for customization after application launch.
    
    example1()
    example2()
    
    return true
  }

}

