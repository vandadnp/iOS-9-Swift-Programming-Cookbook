//
//  ViewController.swift
//  Customizing the Tint Color of Pins on the Map
//
//  Created by Vandad on 7/3/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import MapKit
import SharedCode

class ViewController: UIViewController, MKMapViewDelegate {
  
  @IBOutlet var map: MKMapView!
  let color = UIColor(red: 0.4, green: 0.8, blue: 0.6, alpha: 1.0)
  let location = CLLocationCoordinate2D(latitude: 59.33, longitude: 18.056)
  
  lazy var annotations: [MKAnnotation] = {
    return [Annotation(coordinate: self.location,
      title: "Stockholm Central Station",
      subtitle: "Stockholm, Sweden")]
    }()
  
  func mapView(_ mapView: MKMapView,
    viewFor annotation: MKAnnotation) -> MKAnnotationView? {
      
      let view: MKPinAnnotationView
      if let v = mapView.dequeueReusableAnnotationView(
        withIdentifier: color.toString()) , v is MKPinAnnotationView{
          view = v as! MKPinAnnotationView
      } else {
        view = MKPinAnnotationView(annotation: annotation,
          reuseIdentifier: color.toString())
      }
      
      view.pinTintColor = color
      
      return view
      
  }
  
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    map.removeAnnotations(annotations)
    map.addAnnotations(annotations)
    
  }
  
}
