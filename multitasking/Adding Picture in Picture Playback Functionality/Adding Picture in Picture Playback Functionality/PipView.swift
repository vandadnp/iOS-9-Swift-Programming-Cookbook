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
  
  override open func awakeFromNib() {
    super.awakeFromNib()
    backgroundColor = .black
  }
  
}

class PipView : UIView{
  
  override class var layerClass : AnyClass{
    return AVPlayerLayer.self
  }
 
}
