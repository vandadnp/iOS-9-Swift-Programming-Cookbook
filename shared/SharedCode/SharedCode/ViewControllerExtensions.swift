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
  func alert(_ txt: String){
    let c = UIAlertController(title: nil, message: txt,
      preferredStyle: .alert)
    
    c.addAction(UIAlertAction(title: "OK",
      style: .default, handler: {action in
        self.dismiss(animated: true, completion: nil)
    }))
    
    present(c, animated: true, completion: nil)
  }
}
