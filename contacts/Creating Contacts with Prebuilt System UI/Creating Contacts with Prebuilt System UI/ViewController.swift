//
//  ViewController.swift
//  Creating Contacts with Prebuilt System UI
//
//  Created by Vandad on 7/28/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import UIKit
import ContactsUI
import SharedCode

class ViewController: UIViewController, CNContactViewControllerDelegate{
  
  let store = CNContactStore()
  
  func contactViewController(viewController: CNContactViewController,
    didCompleteWithContact contact: CNContact?) {
      
      //whatever happens, pop back to our view controller
      defer{navigationController?.popViewControllerAnimated(true)}
    
      guard let contact = contact else{
        print("The contact creation was cancelled")
        return
      }
      
      print("Contact was created successfully \(contact)")
      
  }
  
  //Allows the user to create a new contact
  func example1(){
    
    let contact = CNContact().mutableCopy() as! CNMutableContact
    contact.givenName = "Anthony"
    contact.familyName = "Appleseed"
    
    let controller = CNContactViewController(forNewContact: contact)
    controller.contactStore = store
    controller.delegate = self
    
    navigationController?
      .pushViewController(controller, animated: true)
    
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

