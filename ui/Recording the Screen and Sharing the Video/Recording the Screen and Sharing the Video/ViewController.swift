//
//  ViewController.swift
//  Recording the Screen and Sharing the Video
//
//  Created by Vandad on 8/3/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import UIKit
import ReplayKit

class ViewController: UIViewController, RPScreenRecorderDelegate,
RPPreviewViewControllerDelegate {
  
  @IBOutlet var startBtn: UIButton!
  @IBOutlet var stopBtn: UIButton!
  
  func previewControllerDidFinish(previewController: RPPreviewViewController) {
    print("Finished the preview")
    dismissViewControllerAnimated(true, completion: nil)
    startBtn.enabled = true
    stopBtn.enabled = false
  }
  
  func previewController(previewController: RPPreviewViewController,
    didFinishWithActivityTypes activityTypes: Set<String>) {
      print("Preview finished activities \(activityTypes)")
  }
  
  func screenRecorderDidChangeAvailability(screenRecorder: RPScreenRecorder) {
    print("Screen recording availability changed")
  }
  
  func screenRecorder(screenRecorder: RPScreenRecorder,
    didStopRecordingWithError error: NSError,
    previewViewController: RPPreviewViewController?) {
    print("Screen recording finished")
  }
  
  let recorder = RPScreenRecorder.sharedRecorder()

  @IBAction func record() {
    
    startBtn.enabled = true
    stopBtn.enabled = false
    
    guard recorder.available else{
      print("Cannot record the screen")
      return
    }
    
    recorder.delegate = self
    
    recorder.startRecordingWithMicrophoneEnabled(true){err in
      guard err == nil else {
        if err!.code == RPRecordingErrorCode.UserDeclined.rawValue{
          print("User declined app recording")
        }
        else if err!.code == RPRecordingErrorCode.InsufficientStorage.rawValue{
          print("Not enough storage to start recording")
        }
        else {
          print("Error happened = \(err!)")
        }
        return
      }
      
      print("Successfully started recording")
      self.startBtn.enabled = false
      self.stopBtn.enabled = true
      
    }
    
  }
  
  @IBAction func stop() {
    
    recorder.stopRecordingWithHandler{controller, err in
      
      guard let previewController = controller where err == nil else {
        self.startBtn.enabled = true
        self.stopBtn.enabled = false
        print("Failed to stop recording")
        return
      }
      
      previewController.previewControllerDelegate = self
      
      self.presentViewController(previewController, animated: true,
        completion: nil)
      
    }
    
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

