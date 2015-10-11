//
//  ViewController.swift
//  Requesting the User’s Location in Background
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
    m.allowsBackgroundLocationUpdates = true
    return m
    }()
  
  func locationManager(manager: CLLocationManager,
    didUpdateLocations locations: [CLLocation]) {
      //TODO: now you have access to the location. do your work
      
  }
  
  func locationManager(manager: CLLocationManager,
    didFailWithError error: NSError) {
      //TODO: handle the error
  }
  
  func locationManager(manager: CLLocationManager,
    didChangeAuthorizationStatus status: CLAuthorizationStatus) {
      if case CLAuthorizationStatus.AuthorizedAlways = status{
        manager.startUpdatingLocation()
      }
  }

  @IBAction func requestBackgroundLocationUpdates() {
    locationManager.requestAlwaysAuthorization()
  }


}

