//
//  UICollisionBehavior+Additions.swift
//  SharedCode
//
//  Created by Vandad on 8/19/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import Foundation

extension UICollisionBehavior{
  public func addItems(_ items: [UIDynamicItem]){
    for item in items{
      addItem(item)
    }
  }
  public func removeItems(){
    for item in items{
      removeItem(item)
    }
  }
}
