//
//  PipView.swift
//  Adding Picture in Picture Playback Functionality
//
//  Created by Vandad on 7/2/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

protocol Pippable{
  var pipLayer: AVPlayerLayer{get}
  var pipLayerPlayer: AVPlayer? {get set}
}

extension UIView : Pippable{
  
  var pipLayer: AVPlayerLayer{
    get{return layer as! AVPlayerLayer}
  }
  
  //shortcut into pipLayer.player
  var pipLayerPlayer: AVPlayer?{
    get{return pipLayer.player}
    set{pipLayer.player = newValue}
  }
  
  override public func awakeFromNib() {
    super.awakeFromNib()
    backgroundColor = .blackColor()
  }
  
}

class PipView : UIView{
  
  override class func layerClass() -> AnyClass{
    return AVPlayerLayer.self
  }
 
}