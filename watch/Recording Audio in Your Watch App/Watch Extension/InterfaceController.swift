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
  
  var url: URL{
    let fm = FileManager()
    let url = try! fm.url(for: FileManager.SearchPathDirectory.musicDirectory,
      in: FileManager.SearchPathDomainMask.userDomainMask,
      appropriateFor: nil, create: true)
      .appendingPathComponent("recording")
    return url
  }
  
  var status = ""{
    willSet{
      DispatchQueue.main.async{
        self.statusLbl.setText(newValue)
      }
    }
  }
  
  @IBAction func record() {
    
    let oneMinute: TimeInterval = 1 * 60
    
    let yes = NSNumber(value: true as Bool)
    let no = NSNumber(value: false as Bool)
    
    let options = [
      WKAudioRecorderControllerOptionsActionTitleKey : "Audio Recorder",
      WKAudioRecorderControllerOptionsAlwaysShowActionTitleKey : yes,
      WKAudioRecorderControllerOptionsAutorecordKey : no,
      WKAudioRecorderControllerOptionsMaximumDurationKey : oneMinute
    ] as [String : Any]
    
    presentAudioRecorderController(withOutputURL: url,
      preset: WKAudioRecorderPreset.wideBandSpeech,
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
