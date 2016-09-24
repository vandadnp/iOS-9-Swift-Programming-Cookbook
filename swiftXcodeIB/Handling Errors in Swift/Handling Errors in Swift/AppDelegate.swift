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
  
  enum Errors : Error{
    case emptyFirstName
    case emptyLastName
  }
  
  func fullNameFromFirstName(_ firstName: String,
    lastName: String) throws -> String{
    
    if firstName.characters.count == 0{
      throw Errors.emptyFirstName
    }
    
    if lastName.characters.count == 0{
      throw Errors.emptyLastName
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

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    example1()
    example2()

    return true
  }

}

