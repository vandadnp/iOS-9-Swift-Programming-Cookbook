//
//  ViewControllerExtensions.swift
//  SharedCode
//
//  Created by Vandad on 7/2/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import Foundation
import UIKit

public extension UIViewController{
  func alert(txt: String){
    let c = UIAlertController(title: nil, message: txt,
      preferredStyle: .Alert)
    
    c.addAction(UIAlertAction(title: "OK",
      style: .Default, handler: {action in
        self.dismissViewControllerAnimated(true, completion: nil)
    }))
    
    presentViewController(c, animated: true, completion: nil)
  }
}