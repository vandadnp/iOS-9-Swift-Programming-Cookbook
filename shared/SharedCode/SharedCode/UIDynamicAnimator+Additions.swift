//
//  UIDynamicAnimator+Additions.swift
//  SharedCode
//
//  Created by Vandad on 8/19/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import Foundation

extension UIDynamicAnimator{
  public func addBehaviors(_ behaviors: [UIDynamicBehavior]){
    for behavior in behaviors{
      addBehavior(behavior)
    }
  }
}
