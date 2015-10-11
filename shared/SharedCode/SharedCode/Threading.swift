//
//  Threading.swift
//  SharedCode
//
//  Created by Vandad on 8/6/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import Foundation

public func onMainThread(f: () -> Void){
  dispatch_async(dispatch_get_main_queue(), f)
}