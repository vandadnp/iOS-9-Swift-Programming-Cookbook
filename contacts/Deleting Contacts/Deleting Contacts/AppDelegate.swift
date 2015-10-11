//
//  AppDelegate.swift
//  Deleting Contacts
//
//  Created by Vandad on 7/27/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import UIKit
import SharedCode
import Contacts

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  
  let store = CNContactStore()

  func example1(){
    NSOperationQueue().addOperationWithBlock{[unowned store] in
      let predicate = CNContact.predicateForContactsMatchingName("john")
      let toFetch = [CNContactEmailAddressesKey]
      
      do{
        
        let contacts = try store.unifiedContactsMatchingPredicate(predicate,
          keysToFetch: toFetch)
        
        guard contacts.count > 0 else{
          print("No contacts found")
          return
        }
        
        //only do this to the first contact matching our criteria
        guard let contact = contacts.first else{
          return
        }
        
        let req = CNSaveRequest()
        let mutableContact = contact.mutableCopy() as! CNMutableContact
        req.deleteContact(mutableContact)
        
        do{
          try store.executeSaveRequest(req)
          print("Successfully deleted the user")
          
        } catch let e{
          print("Error = \(e)")
        }
        
      } catch let err{
        print(err)
      }
    }
  }

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    ContactAuthorizer.authorizeContactsWithCompletionHandler{
      if $0{
        self.example1()
      }
    }
    return true
  }

}

