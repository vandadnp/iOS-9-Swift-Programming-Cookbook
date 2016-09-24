//
//  Threading.swift
//  SharedCode
//
//  Created by Vandad on 8/6/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import Foundation

public func onMainThread(_ f: @escaping () -> Void){
  DispatchQueue.main.async(execute: f)
}
