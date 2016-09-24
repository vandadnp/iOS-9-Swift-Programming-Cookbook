//
//  ViewController.swift
//  Reading out Text with the Default Siri Alex Voice
//
//  Created by Vandad on 8/3/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVSpeechSynthesizerDelegate{

  @IBOutlet var textView: UITextView!
  
  @IBAction func read(_ sender: AnyObject) {
    
    guard let voice = AVSpeechSynthesisVoice(identifier:
      AVSpeechSynthesisVoiceIdentifierAlex) else{
      print("Alex is not available")
      return
    }
    
    print("id = \(voice.identifier)")
    print("quality = \(voice.quality)")
    print("name = \(voice.name)")
    
    let toSay = AVSpeechUtterance(string: textView.text)
    toSay.voice = voice
    
    let alex = AVSpeechSynthesizer()
    alex.delegate = self
    alex.speak(toSay)
    
  }
  
}

