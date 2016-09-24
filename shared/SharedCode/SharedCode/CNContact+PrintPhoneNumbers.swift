//
//  CNContact+PrintPhoneNumbers.swift
//  SharedCode
//
//  Created by Vandad on 7/28/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import Foundation
import Contacts

public extension CNContact{
  func printPhoneNumbers(){
    guard self.phoneNumbers.count > 0 else{
      print("No phone numbers are available for this user")
      return
    }
    
    for label in self.phoneNumbers{
      let num = label.value 
      print(num.stringValue)
    }
  }
}
