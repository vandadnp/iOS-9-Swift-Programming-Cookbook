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
    OperationQueue().addOperation{[unowned store] in
      let predicate = CNContact.predicateForContacts(matchingName: "john")
      let toFetch = [CNContactEmailAddressesKey]
      
      do{
        
        let contacts = try store.unifiedContacts(matching: predicate,
          keysToFetch: toFetch as [CNKeyDescriptor])
        
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
        req.delete(mutableContact)
        
        do{
          try store.execute(req)
          print("Successfully deleted the user")
          
        } catch let e{
          print("Error = \(e)")
        }
        
      } catch let err{
        print(err)
      }
    }
  }

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    ContactAuthorizer.authorizeContactsWithCompletionHandler{
      if $0{
        self.example1()
      }
    }
    return true
  }

}

