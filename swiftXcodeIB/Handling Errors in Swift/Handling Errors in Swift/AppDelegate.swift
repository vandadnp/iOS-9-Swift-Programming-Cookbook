//
//  AppDelegate.swift
//  Handling Errors in Swift
//
//  Created by Vandad on 6/24/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  
  enum Errors : ErrorType{
    case EmptyFirstName
    case EmptyLastName
  }
  
  func fullNameFromFirstName(firstName: String,
    lastName: String) throws -> String{
    
    if firstName.characters.count == 0{
      throw Errors.EmptyFirstName
    }
    
    if lastName.characters.count == 0{
      throw Errors.EmptyLastName
    }
    
    return firstName + " " + lastName
    
  }
  
  func example1(){
    
    do{
      let fullName = try fullNameFromFirstName("Foo", lastName: "Bar")
      print(fullName)
    } catch {
      print("An error occurred")
    }
    
  }
  
  func example2(){
    
    do{
      let fullName = try fullNameFromFirstName("Foo", lastName: "Bar")
      print(fullName)
    }
    catch let err as Errors{
      //handle this specific type of error here
      print(err)
    }
    catch let ex as NSException{
      //handle exceptions here
      print(ex)
    }
    catch {
      //otherwise, do this
    }
    
  }

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    
    example1()
    example2()

    return true
  }

}

