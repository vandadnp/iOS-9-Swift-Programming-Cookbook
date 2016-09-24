//
//  ViewController.swift
//  Making User Activities Searchable
//
//  Created by Vandad on 7/2/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import UIKit
import CoreSpotlight
import MobileCoreServices

class ViewController: UIViewController, UITextFieldDelegate,
NSUserActivityDelegate {

  @IBOutlet var textField: UITextField!
  @IBOutlet var status: UITextView!
  
  func userActivityWasContinued(_ userActivity: NSUserActivity) {
    log("Activity was continued")
  }
  
  func userActivityWillSave(_ userActivity: NSUserActivity) {
    log("Activity will save")
  }
  
  func log(_ t: String){
    DispatchQueue.main.async {
      self.status.text = t + "\n" + self.status.text
    }
  }
  
  func textFieldText() -> String{
    if let txt = self.textField.text{
      return txt
    } else {
      return ""
    }
  }
  
  //TODO: change this ID to something relevant to your app
  let activityType = "se.pixolity.Making-User-Activities-Searchable.editText"
  let activityTxtKey = "se.pixolity.Making-User-Activities-Searchable.txt"
  
  lazy var activity: NSUserActivity = {
    let a = NSUserActivity(activityType: self.activityType)
    a.title = "Text Editing"
    a.isEligibleForHandoff = true
    a.isEligibleForSearch = true
    //do this only if it makes sense
    //a.eligibleForPublicIndexing = true
    a.delegate = self
    a.keywords = ["txt", "text", "edit", "update"]
    
    let att = CSSearchableItemAttributeSet(
      itemContentType: kUTTypeText as String)
    att.title = a.title
    att.contentDescription = "Editing text right in the app"
    att.keywords = Array(a.keywords)
    
    if let u = Bundle.main.url(forResource: "Icon",
      withExtension: "png"){
        att.thumbnailData = try? Data(contentsOf: u)
    }
    a.contentAttributeSet = att
    
    return a
  }()
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
    log("Activity is current")
    userActivity = activity
    activity.becomeCurrent()
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    log("Activity resigns being current")
    activity.resignCurrent()
    userActivity = nil
  }
  
  func textField(_ textField: UITextField,
    shouldChangeCharactersIn range: NSRange,
    replacementString string: String) -> Bool {
      
      activity.needsSave = true
      
      return true
    
  }
  
  override func updateUserActivityState(_ a: NSUserActivity) {
    
    log("We are asked to update the activity state")
    
    a.addUserInfoEntries(
      from: [self.activityTxtKey : self.textFieldText()])
    
    super.updateUserActivityState(a)
    
  }

}

