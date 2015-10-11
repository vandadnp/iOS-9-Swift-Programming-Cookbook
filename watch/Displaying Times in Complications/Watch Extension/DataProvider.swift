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
  var date: NSDate {get}
}

struct PauseAtWork : Pausable{
  let name: String
  let date: NSDate
}

struct DataProvider{
  
  func allPausesToday() -> [PauseAtWork]{
    
    var all = [PauseAtWork]()
    
    let now = NSDate()
    let cal = NSCalendar.currentCalendar()
    let units = NSCalendarUnit.Year.union(.Month).union(.Day)
    let comps = cal.components(units, fromDate: now)
    comps.calendar = cal
    comps.minute = 30
    
    comps.hour = 11
    all.append(PauseAtWork(name: "Coffee", date: comps.date!))
    
    comps.minute = 30
    comps.hour = 14
    all.append(PauseAtWork(name: "Lunch", date: comps.date!))
    
    comps.minute = 0
    comps.hour = 16
    all.append(PauseAtWork(name: "Tea", date: comps.date!))
    
    comps.hour = 17
    all.append(PauseAtWork(name: "Dinner", date: comps.date!))
    
    return all
    
  }
  
}