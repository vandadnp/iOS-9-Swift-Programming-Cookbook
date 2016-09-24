//
//  ViewController.swift
//  Showing Web Content in Safari View Controller
//
//  Created by Vandad on 6/30/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import UIKit
import SafariServices

class ViewController: UIViewController, SFSafariViewControllerDelegate{
  
  @IBOutlet var textField: UITextField!
  
  func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
    dismiss(animated: true, completion: nil)
  }

  @IBAction func openInSafari() {
    
    guard let t = textField.text , t.characters.count > 0,
      let u = URL(string: t)  else{
      //the url is missing, you can further code this method if you want
      return
    }
    
    let controller = SFSafariViewController(url: u,
      entersReaderIfAvailable: true)
    controller.delegate = self
    present(controller, animated: true, completion: nil)
    
  }
  
}

