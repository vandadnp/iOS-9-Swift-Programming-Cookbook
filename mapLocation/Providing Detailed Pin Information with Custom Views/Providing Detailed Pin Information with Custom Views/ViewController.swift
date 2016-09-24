//
//  ViewController.swift
//  Providing Detailed Pin Information with Custom Views
//
//  Created by Vandad on 7/3/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import UIKit
import MapKit
import SharedCode

class ViewController: UIViewController {
  
  @IBOutlet var map: MKMapView!
  let location = CLLocationCoordinate2D(latitude: 59.33, longitude: 18.056)
  let identifier = "annotation"
  
  lazy var annotations: [MKAnnotation] = {
    return [Annotation(coordinate: self.location,
      title: "Stockholm Central Station",
      subtitle: "Stockholm, Sweden")]
    }()
  
  
  func mapView(_ mapView: MKMapView,
    viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
      
      let view: MKAnnotationView
      if let v = mapView
        .dequeueReusableAnnotationView(withIdentifier: identifier){
          //reuse
          view = v
      } else {
        //create a new one
        view = MKAnnotationView(annotation: annotation,
          reuseIdentifier: identifier)
        
        view.canShowCallout = true
        
        if let img = UIImage(named: "Icon"){
          view.detailCalloutAccessoryView = UIImageView(image: img)
        }
        
        if let extIcon = UIImage(named: "ExtIcon"){
          view.image = extIcon
        }
      }
      
      return view
      
  }
  
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    map.removeAnnotations(annotations)
    map.addAnnotations(annotations)
    
  }
  
  
}

