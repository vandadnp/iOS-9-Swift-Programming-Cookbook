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
  func firstUnifiedContactMatchingName(_ name: String,
    toFetch: [CNKeyDescriptor], output: @escaping (CNContact?) -> Void){
    
    OperationQueue().addOperation{
      let predicate = CNContact.predicateForContacts(matchingName: name)
      
      do{
        
        let contacts = try self.unifiedContacts(matching: predicate,
          keysToFetch: toFetch)
        
        guard contacts.count > 0 else{
          OperationQueue.main.addOperation{output(nil)}
          print("No contacts found")
          return
        }
        
        //only do this to the first contact matching our criteria
        guard let contact = contacts.first else{
          OperationQueue.main.addOperation{output(nil)}
          return
        }
        
        OperationQueue.main.addOperation{output(contact)}
        
      } catch let err{
        print(err)
      }
    }
    
  }
}
