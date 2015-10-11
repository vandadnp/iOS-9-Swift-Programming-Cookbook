//
//  ContactAuthorizer.swift
//  SharedCode
//
//  Created by Vandad on 7/9/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import Foundation
import Contacts

public final class ContactAuthorizer{
  
  public class func authorizeContactsWithCompletionHandler(completionHandler: (succeeded: Bool) -> Void){
    
    switch CNContactStore.authorizationStatusForEntityType(.Contacts){
    case .Authorized:
      completionHandler(succeeded: true)
    case .NotDetermined:
      CNContactStore().requestAccessForEntityType(.Contacts){succeeded, err in
        completionHandler(succeeded: err == nil && succeeded)
      }
    default:
      completionHandler(succeeded: false)
    }
    
  }
  
}