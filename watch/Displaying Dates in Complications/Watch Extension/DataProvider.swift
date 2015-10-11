//
//  DataProvider.swift
//  Constructing Small Complications with Text and Images
//
//  Created by Vandad on 8/7/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import Foundation

protocol Holidayable{
  var date: NSDate {get}
  var name: String {get}
}

struct Holiday : Holidayable{
  let date: NSDate
  let name: String
}

struct DataProvider{
  
  private let holidayNames = [
    "Father's Day",
    "Mother's Day",
    "Bank Holiday",
    "Nobel Day",
    "Man Day",
    "Woman Day",
    "Boyfriend Day",
    "Girlfriend Day",
    "Dog Day",
    "Cat Day",
    "Mouse Day",
    "Cow Day",
  ]
  
  private func randomDay() -> Int{
    return Int(arc4random_uniform(20) + 1)
  }
  
  func allHolidays() -> [Holiday]{
    
    var all = [Holiday]()
    
    let now = NSDate()
    let cal = NSCalendar.currentCalendar()
    let units = NSCalendarUnit.Year.union(.Month).union(.Day)
    let comps = cal.components(units, fromDate: now)
    
    var dates = [NSDate]()
    
    for month in 1...12{
      comps.day = randomDay()
      comps.month = month
      dates.append(cal.dateFromComponents(comps)!)
    }
    
    var i = 0
    for date in dates{
      all.append(Holiday(date: date, name: holidayNames[i++]))
    }
    
    return all
    
  }
  
}