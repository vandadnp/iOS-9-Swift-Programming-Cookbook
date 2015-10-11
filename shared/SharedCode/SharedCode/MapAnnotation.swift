//
//  MapAnnotation.swift
//  SharedCode
//
//  Created by Vandad on 7/3/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import Foundation
import MapKit

public class Annotation : NSObject, MKAnnotation{
  public var coordinate: CLLocationCoordinate2D
  public var title: String?
  public var subtitle: String?
  
  public init(coordinate: CLLocationCoordinate2D,
    title: String, subtitle: String){
    self.coordinate = coordinate
    self.title = title
    self.subtitle = subtitle
  }
  
}