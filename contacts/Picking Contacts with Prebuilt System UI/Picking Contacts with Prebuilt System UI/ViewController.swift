//
//  ViewController.swift
//  Picking Contacts with Prebuilt System UI
//
//  Created by Vandad on 7/28/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import UIKit
import ContactsUI
import SharedCode

class ViewController: UIViewController, CNContactPickerDelegate {
  
  func contactPickerDidCancel(picker: CNContactPickerViewController) {
    print("Cancelled picking a contact")
  }
  
  //i have put aside the contactPicker:didSelectContact method inside
  //this function for example4() to be able to run properly but didn't
  //want to comment this code out, as later when updating all the codes
  //for newer Xcode versions, I wouldn't be able to see if it compiles
  //fine or not
  func commentedOutForExample4(){
    func contactPicker(picker: CNContactPickerViewController,
      didSelectContact contact: CNContact) {
        
        print("Selected a contact")
        
        if contact.isKeyAvailable(CNContactPhoneNumbersKey){
          //this is an extension I've written on CNContact
          contact.printPhoneNumbers()
        } else {
          /*
          TOOD: partially fetched, use what you've learnt in this chapter to
          fetch the rest of this contact
          */
          print("No phone numbers are available")
        }
        
    }
  }
  
  //allows any contact to be selected and returned to our app
  func example1(){
    let controller = CNContactPickerViewController()
    
    controller.delegate = self
    
    navigationController?.presentViewController(controller,
      animated: true, completion: nil)
  }
  
  //allows the selection of contacts with at least 1 phone number whose 
  //given names begins with 'John'
  func example2(){
    
    let controller = CNContactPickerViewController()
    
    controller.delegate = self
    
    controller.predicateForEnablingContact =
      NSPredicate(format:
        "phoneNumbers.@count > 0 && givenName BEGINSWITH 'John'",
        argumentArray: nil)
    
    navigationController?.presentViewController(controller,
      animated: true, completion: nil)
    
  }
  
  //allows the user to pick any contact with a phone number. Those without a
  //phone number will have their details displayed instead
  func example3(){
    let controller = CNContactPickerViewController()
    
    controller.delegate = self
    
    controller.predicateForSelectionOfContact =
      NSPredicate(format:
        "phoneNumbers.@count > 0",
        argumentArray: nil)
    
    navigationController?.presentViewController(controller,
      animated: true, completion: nil)
  }
  
  func contactPicker(picker: CNContactPickerViewController,
    didSelectContactProperty contactProperty: CNContactProperty) {
      
      print("Selected a property")
      
  }
  
  //allows contacts with phone numbers to have their first phone number
  //to be picked and returned to our app
  func example4(){
    let controller = CNContactPickerViewController()
    
    controller.delegate = self
    
    controller.predicateForEnablingContact =
      NSPredicate(format:
        "phoneNumbers.@count > 0",
        argumentArray: nil)
    
    controller.predicateForSelectionOfProperty =
      NSPredicate(format: "key == 'phoneNumbers'", argumentArray: nil)
    
    navigationController?.presentViewController(controller,
      animated: true, completion: nil)
  }
  
  func contactPicker(picker: CNContactPickerViewController,
    didSelectContacts contacts: [CNContact]) {
    print("Selected \(contacts.count) contacts")
  }
  
  //allows multiple selection mixed with contactPicker:didSelectContacts:
  func example5(){
    let controller = CNContactPickerViewController()
    
    controller.delegate = self

    navigationController?.presentViewController(controller,
      animated: true, completion: nil)
  }

  @IBAction func pickaContact() {
    example5()
  }

}

