//
//  AppDelegate.swift
//  Optimizing Your Swift Code
//
//  Created by Vandad on 6/26/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  
  class Person{
    let name: String
    let age: Int
    init(name: String, age: Int){
      self.name = name
      self.age = age
    }
  }
  
  func example1(){
    
    var x = CFAbsoluteTimeGetCurrent()
    
    var array = [Person]()
    
    for _ in 0..<100000{
      array.append(Person(name: "Foo", age: 30))
    }
    
    //go through the items as well
    for n in 0..<array.count{
      let _ = array[n]
    }
    
    x = (CFAbsoluteTimeGetCurrent() - x) * 1000.0
    
    print("Took \(x) milliseconds")
    
  }
  
  struct PersonStruct{
    let name: String
    let age: Int
  }
  
  func example2(){
    
    var x = CFAbsoluteTimeGetCurrent()
    
    var array = [PersonStruct]()
    
    for _ in 0..<100000{
      array.append(PersonStruct(name: "Foo", age: 30))
    }
    
    //go through the items as well
    for n in 0..<array.count{
      let _ = array[n]
    }
    
    x = (CFAbsoluteTimeGetCurrent() - x) * 1000.0
    
    print("Took \(x) milliseconds")
    
  }
  
  class Animal{
    func move(){
      if "Foo".characters.count > 0{
        //some code
      }
    }
  }
  
  class Dog : Animal{
    
  }
  
  func example3(){
    var x = CFAbsoluteTimeGetCurrent()
    var array = [Dog]()
    for n in 0..<100000{
      array.append(Dog())
      array[n].move()
    }
    x = (CFAbsoluteTimeGetCurrent() - x) * 1000.0
    print("Took \(x) milliseconds")
  }
  
  class AnimalOptimized{
    final func move(){
      if "Foo".characters.count > 0{
        //some code
      }
    }
  }
  
  class DogOptimized : AnimalOptimized{
    
  }
  
  func example4(){
    var x = CFAbsoluteTimeGetCurrent()
    var array = [DogOptimized]()
    for n in 0..<100000{
      array.append(DogOptimized())
      array[n].move()
    }
    x = (CFAbsoluteTimeGetCurrent() - x) * 1000.0
    print("Took \(x) milliseconds")
  }

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    // Override point for customization after application launch.
    
    example1()
    example2()
    example3()
    example4()
    
    return true
  }

}

