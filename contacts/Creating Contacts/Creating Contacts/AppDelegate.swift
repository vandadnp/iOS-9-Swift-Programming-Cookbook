//
//  AppDelegate.swift
//  Creating Contacts
//
//  Created by Vandad on 7/8/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import UIKit
import Contacts
import SharedCode

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  var store = CNContactStore()
  
  func createContact(){
    
    let fooBar = CNMutableContact()
    fooBar.givenName = "Foo"
    fooBar.middleName = "A."
    fooBar.familyName = "Bar"
    fooBar.nickname = "Fooboo"
    
    //profile photo
    if let img = UIImage(named: "apple"),
      let data = UIImagePNGRepresentation(img){
      fooBar.imageData = data
    }
    
    //set the phone numbers
    let homePhone = CNLabeledValue(label: CNLabelHome,
      value: CNPhoneNumber(stringValue: "123"))
    let workPhone = CNLabeledValue(label: CNLabelWork,
      value: CNPhoneNumber(stringValue: "567"))
    fooBar.phoneNumbers = [homePhone, workPhone]
    
    //set the email addresses
    let homeEmail = CNLabeledValue(label: CNLabelHome,
      value: "foo@home" as NSString)
    let workEmail = CNLabeledValue(label: CNLabelWork,
      value: "bar@home" as NSString)
    fooBar.emailAddresses = [homeEmail, workEmail]
    
    //job info
    fooBar.jobTitle = "Chief Awesomeness Manager (CAM)"
    fooBar.organizationName = "Pixolity"
    fooBar.departmentName = "IT"
    
    //social media
    let facebookProfile = CNLabeledValue(label: "FaceBook", value:
      CNSocialProfile(urlString: nil, username: "foobar",
      userIdentifier: nil, service: CNSocialProfileServiceFacebook))
    let twitterProfile = CNLabeledValue(label: "Twitter", value:
      CNSocialProfile(urlString: nil, username: "foobar",
        userIdentifier: nil, service: CNSocialProfileServiceTwitter))
    fooBar.socialProfiles = [facebookProfile, twitterProfile]
    
    //instant messaging
    let skypeAddress = CNLabeledValue(label: "Skype", value:
    CNInstantMessageAddress(username: "foobar",
      service: CNInstantMessageServiceSkype))
    let aimAddress = CNLabeledValue(label: "AIM", value:
    CNInstantMessageAddress(username: "foobar",
      service: CNInstantMessageServiceAIM))
    fooBar.instantMessageAddresses = [skypeAddress, aimAddress]
    
    //some additional notes
    fooBar.note = "Some additional notes"
    
    //birthday
    var birthday = DateComponents()
    birthday.year = 1980
    birthday.month = 9
    birthday.day = 27
    fooBar.birthday = birthday
    
    //anniversary
    var anniversaryDate = DateComponents()
    anniversaryDate.month = 6
    anniversaryDate.day = 13
    let anniversary = CNLabeledValue(label: "Anniversary",
      value: anniversaryDate as NSDateComponents)
    fooBar.dates = [anniversary]
    
    //finally save
    let request = CNSaveRequest()
    request.add(fooBar, toContainerWithIdentifier: nil)
    do{
      try store.execute(request)
      print("Successfully stored the contact")
    } catch let err{
      print("Failed to save the contact. \(err)")
    }
    
  }

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    ContactAuthorizer.authorizeContactsWithCompletionHandler {succeeded in
      if succeeded{
        self.createContact()
      } else{
        print("Not handled")
      }
    }

    return true
  }

}

