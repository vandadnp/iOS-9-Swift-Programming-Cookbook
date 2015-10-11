//
//  ViewController.swift
//  Adding Picture in Picture Playback Functionality
//
//  Created by Vandad on 7/2/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import SharedCode

private var kvoContext = 0
let pipPossible = "pictureInPicturePossible"
let currentItemStatus = "currentItem.status"

protocol PippableViewController{
  var pipView: PipView {get}
}
extension ViewController : PippableViewController{
  var pipView: PipView{
    return view as! PipView
  }
}

class ViewController: UIViewController, AVPictureInPictureControllerDelegate {
  
  @IBOutlet var beginPipBtn: UIBarButtonItem!
  
  lazy var player: AVPlayer = {
    let p = AVPlayer()
    p.addObserver(self, forKeyPath: currentItemStatus,
      options: .New, context: &kvoContext)
    return p
  }()
  
  var pipController: AVPictureInPictureController?
  
  var videoUrl: NSURL? = nil{
    didSet{
      if let u = videoUrl{
        let asset = AVAsset(URL: u)
        let item = AVPlayerItem(asset: asset,
          automaticallyLoadedAssetKeys: ["playable"])
        player.replaceCurrentItemWithPlayerItem(item)
        pipView.pipLayerPlayer = player
      }
    }
  }
  
  var embeddedVideo: NSURL?{
    return NSBundle.mainBundle().URLForResource("video", withExtension: "mp4")
  }
  
  func isPipSupported() -> Bool{
    guard AVPictureInPictureController.isPictureInPictureSupported() else{
      //no pip
      return false
    }
    
    return true
  }
  
  func setAudioCategory() -> Bool{
    //set the audio category
    do{
      try AVAudioSession.sharedInstance().setCategory(
        AVAudioSessionCategoryPlayback)
      return true
    } catch {
      return false
    }
  }
  
  func startPipController(){
    pipController = AVPictureInPictureController(playerLayer: pipView.pipLayer)
    guard let controller = pipController else{
      return
    }
    
    controller.addObserver(self, forKeyPath: pipPossible,
      options: .New, context: &kvoContext)
  }
  
  @IBAction func play() {
    guard setAudioCategory() else{
      alert("Could not set the audio category")
      return
    }
    
    guard let u = embeddedVideo else{
      alert("Cannot find the embedded video")
      return
    }
    
    videoUrl = u
    player.play()
    
  }

  @IBAction func beginPip() {
    
    guard isPipSupported() else{
      alert("PiP is not supported on your machine")
      return
    }
    
    guard let controller = pipController else{
      alert("Could not instantiate the pip controller")
      return
    }
    
    controller.addObserver(self, forKeyPath: pipPossible,
      options: .New, context: &kvoContext)
    
    if controller.pictureInPicturePossible{
      controller.startPictureInPicture()
    } else {
      alert("Pip is not possible")
    }
    
  }
  
  override func observeValueForKeyPath(keyPath: String?,
    ofObject object: AnyObject?,
    change: [String : AnyObject]?,
    context: UnsafeMutablePointer<Void>) {
      
      guard context == &kvoContext else{
        return
      }
      
      if keyPath == pipPossible{
        guard let possibleInt = change?[NSKeyValueChangeNewKey]
          as? NSNumber else{
            beginPipBtn.enabled = false
            return
        }
        
        beginPipBtn.enabled = possibleInt.boolValue
        
      }
      
      else if keyPath == currentItemStatus{
        
        guard let statusInt = change?[NSKeyValueChangeNewKey] as? NSNumber,
          let status = AVPlayerItemStatus(rawValue: statusInt.integerValue)
          where status == .ReadyToPlay else{
            return
        }
        
        startPipController()
        
      }
    
  }

}

