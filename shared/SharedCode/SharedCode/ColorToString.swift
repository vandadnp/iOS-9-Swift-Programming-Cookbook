//
//  ColorToString.swift
//  SharedCode
//
//  Created by Vandad on 7/3/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import Foundation
import UIKit

public extension UIColor{
  final func toString() -> String{
    
    var red = 0.0 as CGFloat
    var green = 0.0 as CGFloat
    var blue = 0.0 as CGFloat
    var alpha = 0.0 as CGFloat
    getRed(&red, green: &green, blue: &blue, alpha: &alpha)
    
    return "\(Int(red))\(Int(green))\(Int(blue))\(Int(alpha))"
  }
}