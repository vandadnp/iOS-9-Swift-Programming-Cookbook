//
//  ViewController.swift
//  Launching the iOS Maps App in Transit Mode
//
//  Created by Vandad on 7/4/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

  @IBAction func open() {
    
    let srcLoc = CLLocationCoordinate2D(latitude: 59.328564,
      longitude: 18.061448)
    let srcPlc = MKPlacemark(coordinate: srcLoc, addressDictionary: nil)
    let src = MKMapItem(placemark: srcPlc)
    
    let desLoc = CLLocationCoordinate2D(latitude: 59.746148,
      longitude: 18.683281)
    let desPlc = MKPlacemark(coordinate: desLoc, addressDictionary: nil)
    let des = MKMapItem(placemark: desPlc)
    
    let options = [
      MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeTransit
    ]
    
    MKMapItem.openMaps(with: [src, des], launchOptions: options)
    
  }
  
}

