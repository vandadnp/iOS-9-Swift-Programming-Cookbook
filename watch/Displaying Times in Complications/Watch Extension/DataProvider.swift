//
//  DataProvider.swift
//  Constructing Small Complications with Text and Images
//
//  Created by Vandad on 8/7/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import Foundation

protocol Pausable{
  var name: String {get}
  var date: Date {get}
}

struct PauseAtWork : Pausable{
  let name: String
  let date: Date
}

struct DataProvider{
  
  func allPausesToday() -> [PauseAtWork]{
    
    var all = [PauseAtWork]()
    
    let now = Date()
    let cal = Calendar.current
    let units = NSCalendar.Unit.year.union(.month).union(.day)
    var comps = (cal as NSCalendar).components(units, from: now)
    (comps as NSDateComponents).calendar = cal
    comps.minute = 30
    
    comps.hour = 11
    all.append(PauseAtWork(name: "Coffee", date: (comps as NSDateComponents).date!))
    
    comps.minute = 30
    comps.hour = 14
    all.append(PauseAtWork(name: "Lunch", date: (comps as NSDateComponents).date!))
    
    comps.minute = 0
    comps.hour = 16
    all.append(PauseAtWork(name: "Tea", date: (comps as NSDateComponents).date!))
    
    comps.hour = 17
    all.append(PauseAtWork(name: "Dinner", date: (comps as NSDateComponents).date!))
    
    return all
    
  }
  
}
