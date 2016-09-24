//
//  CFStringRef+ToString.swift
//  SharedCode
//
//  Created by Vandad on 8/3/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import Foundation

extension CFString{
  public func str() -> String{
    return String(self)
  }
}


