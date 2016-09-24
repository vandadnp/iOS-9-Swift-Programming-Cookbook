//
//  ViewController.swift
//  Displaying Contacts with Prebuilt System UI
//
//  Created by Vandad on 7/28/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import UIKit
import ContactsUI
import SharedCode

class ViewController: UIViewController{
  
  let store = CNContactStore()
  
  //Allows the user to view a contact
  func example1(){
    
    let toFetch = [CNContactViewController.descriptorForRequiredKeys()]
    store.firstUnifiedContactMatchingName("john", toFetch: toFetch){
      
      guard let contact = $0 else{
        print("No contact was found")
        return
      }
      
      let controller = CNContactViewController(for: contact)
      controller.contactStore = self.store
      controller.allowsEditing = false
      
      controller.displayedPropertyKeys =
        [CNContactEmailAddressesKey, CNContactPostalAddressesKey]
      
      self.navigationController?
        .pushViewController(controller, animated: true)
      
    }
    
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    ContactAuthorizer.authorizeContactsWithCompletionHandler{
      if $0{
        self.example1()
      }
    }
    
  }
  
}
