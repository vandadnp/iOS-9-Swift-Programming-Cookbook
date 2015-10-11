//
//  CNContactStore+ContactFetcher.swift
//  SharedCode
//
//  Created by Vandad on 7/27/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import Foundation
import Contacts

public extension CNContactStore{
  func firstUnifiedContactMatchingName(name: String,
    toFetch: [CNKeyDescriptor], output: CNContact? -> Void){
    
    NSOperationQueue().addOperationWithBlock{
      let predicate = CNContact.predicateForContactsMatchingName(name)
      
      do{
        
        let contacts = try self.unifiedContactsMatchingPredicate(predicate,
          keysToFetch: toFetch)
        
        guard contacts.count > 0 else{
          NSOperationQueue.mainQueue().addOperationWithBlock{output(nil)}
          print("No contacts found")
          return
        }
        
        //only do this to the first contact matching our criteria
        guard let contact = contacts.first else{
          NSOperationQueue.mainQueue().addOperationWithBlock{output(nil)}
          return
        }
        
        NSOperationQueue.mainQueue().addOperationWithBlock{output(contact)}
        
      } catch let err{
        print(err)
      }
    }
    
  }
}