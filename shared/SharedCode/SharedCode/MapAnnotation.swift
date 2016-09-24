//
//  MapAnnotation.swift
//  SharedCode
//
//  Created by Vandad on 7/3/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import Foundation
import MapKit

open class Annotation : NSObject, MKAnnotation{
  open var coordinate: CLLocationCoordinate2D
  open var title: String?
  open var subtitle: String?
  
  public init(coordinate: CLLocationCoordinate2D,
    title: String, subtitle: String){
    self.coordinate = coordinate
    self.title = title
    self.subtitle = subtitle
  }
  
}
