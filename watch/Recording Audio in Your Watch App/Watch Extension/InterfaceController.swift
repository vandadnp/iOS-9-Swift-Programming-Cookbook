//
//  InterfaceController.swift
//  Watch Extension
//
//  Created by Vandad on 8/11/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import WatchKit
import Foundation

class InterfaceController: WKInterfaceController {
  
  @IBOutlet var statusLbl: WKInterfaceLabel!
  
  var url: NSURL{
    let fm = NSFileManager()
    let url = try! fm.URLForDirectory(NSSearchPathDirectory.MusicDirectory,
      inDomain: NSSearchPathDomainMask.UserDomainMask,
      appropriateForURL: nil, create: true)
      .URLByAppendingPathComponent("recording")
    return url
  }
  
  var status = ""{
    willSet{
      dispatch_async(dispatch_get_main_queue()){
        self.statusLbl.setText(newValue)
      }
    }
  }
  
  @IBAction func record() {
    
    let oneMinute: NSTimeInterval = 1 * 60
    
    let yes = NSNumber(bool: true)
    let no = NSNumber(bool: false)
    
    let options = [
      WKAudioRecorderControllerOptionsActionTitleKey : "Audio Recorder",
      WKAudioRecorderControllerOptionsAlwaysShowActionTitleKey : yes,
      WKAudioRecorderControllerOptionsAutorecordKey : no,
      WKAudioRecorderControllerOptionsMaximumDurationKey : oneMinute
    ]
    
    presentAudioRecorderControllerWithOutputURL(url,
      preset: WKAudioRecorderPreset.WideBandSpeech,
      options: options){
        success, error in
        
        defer{
          self.dismissAudioRecorderController()
        }
        
        guard success && error == nil else{
          self.status = "Failed to record"
          return
        }
        
        self.status = "Successfully recorded"
        
    }
    
  }
  
}
