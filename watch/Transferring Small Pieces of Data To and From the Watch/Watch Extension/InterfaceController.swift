//
//  InterfaceController.swift
//  Watch Extension
//
//  Created by Vandad on 8/5/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import WatchKit
import Foundation

class InterfaceController: WKInterfaceController {
  
  @IBOutlet var statusLabel: WKInterfaceLabel!
  
  var status = "Waiting"{
    didSet{
      statusLabel.setText(status)
    }
  }
  
}
