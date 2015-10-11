//
//  ViewController.swift
//  Showing Maps in Flyover Mode
//
//  Created by Vandad on 7/4/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

  @IBOutlet var map: MKMapView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    map.mapType = .SatelliteFlyover
    map.showsBuildings = true
    
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    
    let loc = CLLocationCoordinate2D(latitude: 59.328564,
      longitude: 18.061448)
    
    let altitude: CLLocationDistance  = 500
    let pitch = CGFloat(45)
    let heading: CLLocationDirection = 90
    
    let c = MKMapCamera(lookingAtCenterCoordinate: loc,
      fromDistance: altitude, pitch: pitch, heading: heading)
    
    map.setCamera(c, animated: true)
    
  }


}

