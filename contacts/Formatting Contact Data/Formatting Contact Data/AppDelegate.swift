//
//  AppDelegate.swift
//  Formatting Contact Data
//
//  Created by Vandad on 7/27/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import UIKit
import Contacts
import SharedCode

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  
  let store = CNContactStore()
  
  //finds the first "john" and prints its name to the console
  func example1(){
    
    let toFetch =
    CNContactFormatter.descriptorForRequiredKeysForStyle(.FullName)
    
    store.firstUnifiedContactMatchingName("john", toFetch: [toFetch]){
      guard let contact = $0 else{
        return
      }
      
      guard let name = CNContactFormatter().stringFromContact(contact) else{
        return
      }
      
      print("The name of the contact is \(name)")
      
    }
    
  }
  
  func example2(){
    
    let style = CNContactFormatterStyle.PhoneticFullName
    
    let toFetch =
    CNContactFormatter.descriptorForRequiredKeysForStyle(style)
    
    store.firstUnifiedContactMatchingName("julian", toFetch: [toFetch]){
      
      guard let contact = $0 else{
        return
      }
      
      guard let name = CNContactFormatter
        .stringFromContact(contact, style: style) else{
        return
      }
      
      print("The phonetic name of the contact is \(name)")
      
    }
    
  }
  
  func example3(){
    
    let toFetch = [CNContactPostalAddressesKey]
    
    store.firstUnifiedContactMatchingName("john", toFetch: toFetch){
      guard let contact = $0 else{
        return
      }
      
      guard let firstAddress = contact.postalAddresses.first else{
        print("no postal address could be found")
        return
      }
      
      guard let address = firstAddress.value as? CNPostalAddress
        where firstAddress.value is CNPostalAddress else{
        return
      }
      
      let formatter = CNPostalAddressFormatter()
      let formattedAddress = formatter.stringFromPostalAddress(address)
      
      print("The address is \(formattedAddress)")
      
    }
    
  }

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    
    ContactAuthorizer.authorizeContactsWithCompletionHandler{
      if $0{
        self.example1()
        self.example2()
        self.example3()
      }
    }

    return true
  }

}

