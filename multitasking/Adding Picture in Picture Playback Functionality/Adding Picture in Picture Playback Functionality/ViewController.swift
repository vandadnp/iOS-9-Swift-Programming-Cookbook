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
      options: .new, context: &kvoContext)
    return p
  }()
  
  var pipController: AVPictureInPictureController?
  
  var videoUrl: URL? = nil{
    didSet{
      if let u = videoUrl{
        let asset = AVAsset(url: u)
        let item = AVPlayerItem(asset: asset,
          automaticallyLoadedAssetKeys: ["playable"])
        player.replaceCurrentItem(with: item)
        pipView.pipLayerPlayer = player
      }
    }
  }
  
  var embeddedVideo: URL?{
    return Bundle.main.url(forResource: "video", withExtension: "mp4")
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
      options: .new, context: &kvoContext)
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
      options: .new, context: &kvoContext)
    
    if controller.isPictureInPicturePossible{
      controller.startPictureInPicture()
    } else {
      alert("Pip is not possible")
    }
    
  }
  
  override func observeValue(forKeyPath keyPath: String?,
    of object: Any?,
    change: [NSKeyValueChangeKey : Any]?,
    context: UnsafeMutableRawPointer?) {
      
      guard context == &kvoContext else{
        return
      }
      
      if keyPath == pipPossible{
        guard let possibleInt = change?[NSKeyValueChangeKey.newKey]
          as? NSNumber else{
            beginPipBtn.isEnabled = false
            return
        }
        
        beginPipBtn.isEnabled = possibleInt.boolValue
        
      }
      
      else if keyPath == currentItemStatus{
        
        guard let statusInt = change?[NSKeyValueChangeKey.newKey] as? NSNumber,
          let status = AVPlayerItemStatus(rawValue: statusInt.intValue)
          , status == .readyToPlay else{
            return
        }
        
        startPipController()
        
      }
    
  }

}

