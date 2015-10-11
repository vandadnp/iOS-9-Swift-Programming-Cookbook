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
  
  func userActivityWasContinued(userActivity: NSUserActivity) {
    log("Activity was continued")
  }
  
  func userActivityWillSave(userActivity: NSUserActivity) {
    log("Activity will save")
  }
  
  func log(t: String){
    dispatch_async(dispatch_get_main_queue()) {
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
    a.eligibleForHandoff = true
    a.eligibleForSearch = true
    //do this only if it makes sense
    //a.eligibleForPublicIndexing = true
    a.delegate = self
    a.keywords = ["txt", "text", "edit", "update"]
    
    let att = CSSearchableItemAttributeSet(
      itemContentType: kUTTypeText as String)
    att.title = a.title
    att.contentDescription = "Editing text right in the app"
    att.keywords = Array(a.keywords)
    
    if let u = NSBundle.mainBundle().URLForResource("Icon",
      withExtension: "png"){
        att.thumbnailData = NSData(contentsOfURL: u)
    }
    a.contentAttributeSet = att
    
    return a
  }()
  
  func textFieldDidBeginEditing(textField: UITextField) {
    log("Activity is current")
    userActivity = activity
    activity.becomeCurrent()
  }
  
  func textFieldDidEndEditing(textField: UITextField) {
    log("Activity resigns being current")
    activity.resignCurrent()
    userActivity = nil
  }
  
  func textField(textField: UITextField,
    shouldChangeCharactersInRange range: NSRange,
    replacementString string: String) -> Bool {
      
      activity.needsSave = true
      
      return true
    
  }
  
  override func updateUserActivityState(a: NSUserActivity) {
    
    log("We are asked to update the activity state")
    
    a.addUserInfoEntriesFromDictionary(
      [self.activityTxtKey : self.textFieldText()])
    
    super.updateUserActivityState(a)
    
  }

}

