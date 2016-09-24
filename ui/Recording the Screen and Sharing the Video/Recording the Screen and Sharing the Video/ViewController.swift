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
  
  func previewControllerDidFinish(_ previewController: RPPreviewViewController) {
    print("Finished the preview")
    dismiss(animated: true, completion: nil)
    startBtn.isEnabled = true
    stopBtn.isEnabled = false
  }
  
  func previewController(_ previewController: RPPreviewViewController,
    didFinishWithActivityTypes activityTypes: Set<String>) {
      print("Preview finished activities \(activityTypes)")
  }
  
  func screenRecorderDidChangeAvailability(_ screenRecorder: RPScreenRecorder) {
    print("Screen recording availability changed")
  }
  
  func screenRecorder(_ screenRecorder: RPScreenRecorder,
    didStopRecordingWithError error: Error,
    previewViewController: RPPreviewViewController?) {
    print("Screen recording finished")
  }
  
  let recorder = RPScreenRecorder.shared()

  @IBAction func record() {
    
    startBtn.isEnabled = true
    stopBtn.isEnabled = false
    
    guard recorder.isAvailable else{
      print("Cannot record the screen")
      return
    }
    
    recorder.delegate = self
    
    recorder.startRecording(withMicrophoneEnabled: true){err in
      
      if let error = err as? NSError{
        if error.code == RPRecordingErrorCode.userDeclined.rawValue{
          print("User declined app recording")
        }
        else if error.code == RPRecordingErrorCode.insufficientStorage.rawValue{
          print("Not enough storage to start recording")
        }
        else {
          print("Error happened = \(err!)")
        }
        return
      }
      
      print("Successfully started recording")
      self.startBtn.isEnabled = false
      self.stopBtn.isEnabled = true
      
    }
    
  }
  
  @IBAction func stop() {
    
    recorder.stopRecording{controller, err in
      
      guard let previewController = controller , err == nil else {
        self.startBtn.isEnabled = true
        self.stopBtn.isEnabled = false
        print("Failed to stop recording")
        return
      }
      
      previewController.previewControllerDelegate = self
      
      self.present(previewController, animated: true,
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

