//
//  AppDelegate.swift
//  Updating Contacts
//
//  Created by Vandad on 7/10/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import UIKit
import SharedCode
import Contacts

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  var store = CNContactStore()
  
  //find a contact named "John" and add a new email address to it
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
        
        let newEmail = "newemail@work.com"
        
        for email in contact.emailAddresses{
          if email.value as! String == newEmail{
            print("This contact already has this email")
            return
          }
        }
        
        let john = contact.mutableCopy() as! CNMutableContact
        
        let emailAddress = CNLabeledValue(label: CNLabelWork,
          value: "newemail@work.com")
        
        john.emailAddresses.append(emailAddress)
        
        let req = CNSaveRequest()
        req.updateContact(john)
        
        try store.executeSaveRequest(req)
        
        print("Successfully added an email")
        
      } catch let err{
        print(err)
      }
    }
    
  }
  
  //find all contacts who don't have a note and set a note for them
  func example2(){
    
    NSOperationQueue().addOperationWithBlock{[unowned store] in
      let keys = [CNContactNoteKey]
      let req = CNContactFetchRequest(keysToFetch: keys)
      do{
        try store.enumerateContactsWithFetchRequest(req){contact, stop in
          if contact.note.characters.count == 0{
            
            let updated = contact.mutableCopy() as! CNMutableContact
            updated.note = "Some note"
            let req = CNSaveRequest()
            req.updateContact(updated)
            do{
              try store.executeSaveRequest(req)
              print("Successfully added a note")
            } catch let err{
              print(err)
            }
          }
        }
      } catch let err{
        print(err)
      }
    }
  }
  
  //remove illegal characters from the first and last name of all contacts
  func example3(){
    NSOperationQueue().addOperationWithBlock{[unowned store] in
      let keys = [CNContactGivenNameKey, CNContactFamilyNameKey]
      let req = CNContactFetchRequest(keysToFetch: keys)
      do{
        try store.enumerateContactsWithFetchRequest(req){contact, stop in
          
          let illegalCharacters = NSCharacterSet.letterCharacterSet()
            .invertedSet
          
          let first = NSString(string: contact.givenName)
          let last = NSString(string: contact.familyName)
          
          let foundIllegalCharactersInFirstName =
          first.rangeOfCharacterFromSet(illegalCharacters).location
            != NSNotFound
          
          let foundIllegalCharactersInLastName =
          last.rangeOfCharacterFromSet(illegalCharacters).location
            != NSNotFound
          
          if foundIllegalCharactersInFirstName ||
            foundIllegalCharactersInLastName{
              
              let cleanFirstName =
              (first.componentsSeparatedByCharactersInSet(illegalCharacters)
                as NSArray).componentsJoinedByString("")
              
              let cleanLastName =
              (last.componentsSeparatedByCharactersInSet(illegalCharacters)
                as NSArray).componentsJoinedByString("")
              
              
              let newContact = contact.mutableCopy() as! CNMutableContact
              let req = CNSaveRequest()
              newContact.givenName = cleanFirstName
              newContact.familyName = cleanLastName
              req.updateContact(newContact)
              
              do{
                try store.executeSaveRequest(req)
                print("Successfully removed illegal characters from contact")
              } catch let err{
                print(err)
              }
              
          }
          
        }
      } catch let err{
        print(err)
      }
    }
  }
  
  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    
    ContactAuthorizer.authorizeContactsWithCompletionHandler{succeeded in
      if succeeded{
        self.example1()
        self.example2()
        self.example3()
      } else {
        print("Unhandled")
      }
    }
    
    return true
  }

}

