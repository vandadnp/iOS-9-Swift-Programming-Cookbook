//
//  ViewController.swift
//  Requesting the User’s Location Only Once
//
//  Created by Vandad on 7/3/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
  
  lazy var locationManager: CLLocationManager = {
    let m = CLLocationManager()
    m.delegate = self
    m.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
    return m
  }()
  
  func locationManager(_ manager: CLLocationManager,
    didUpdateLocations locations: [CLLocation]) {
      //TODO: now you have access to the location. do your work
  }
  
  func locationManager(_ manager: CLLocationManager,
    didFailWithError error: Error) {
    //TODO: handle the error
  }
  
  func locationManager(_ manager: CLLocationManager,
    didChangeAuthorization status: CLAuthorizationStatus) {
    
      if case .authorizedWhenInUse = status{
        manager.requestLocation()
      } else {
        //TODO: we didn't get access, handle this
      }
      
  }

  @IBAction func requestLocation() {
    
    locationManager.requestWhenInUseAuthorization()
    
  }
  
}

