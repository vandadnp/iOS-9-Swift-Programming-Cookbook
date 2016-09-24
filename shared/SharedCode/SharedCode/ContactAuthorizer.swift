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
  
  public class func authorizeContactsWithCompletionHandler(_ completionHandler: @escaping (_ succeeded: Bool) -> Void){
    
    switch CNContactStore.authorizationStatus(for: .contacts){
    case .authorized:
      completionHandler(true)
    case .notDetermined:
      CNContactStore().requestAccess(for: .contacts){succeeded, err in
        completionHandler(err == nil && succeeded)
      }
    default:
      completionHandler(false)
    }
    
  }
  
}
