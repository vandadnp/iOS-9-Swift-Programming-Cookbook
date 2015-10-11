//
//  DataProvider.swift
//  Constructing Small Complications with Text and Images
//
//  Created by Vandad on 8/7/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import Foundation

protocol WithDate{
  var hour: Int {get}
  var date: NSDate {get}
  var fraction: Float {get}
}

struct Data : WithDate{
  let hour: Int
  let date: NSDate
  let fraction: Float
  var hourAsStr: String{
    return "\(hour)"
  }
}

extension NSDate{
  func hour() -> Int{
    let cal = NSCalendar.currentCalendar()
    return cal.components(NSCalendarUnit.Hour, fromDate: self).hour
  }
}

extension CollectionType where Generator.Element : WithDate {
  
  func dataForNow() -> Generator.Element?{
    let thisHour = NSDate().hour()
    for d in self{
      if d.hour == thisHour{
        return d
      }
    }
    return nil
  }
  
}

struct DataProvider{
  
  func allDataForToday() -> [Data]{
    
    var all = [Data]()
    
    let now = NSDate()
    let cal = NSCalendar.currentCalendar()
    let units = NSCalendarUnit.Year.union(.Month).union(.Day)
    let comps = cal.components(units, fromDate: now)
    comps.minute = 0
    comps.second = 0
    for i in 1...24{
      comps.hour = i
      let date = cal.dateFromComponents(comps)!
      let fraction = Float(comps.hour) / 24.0
      let data = Data(hour: comps.hour, date: date, fraction: fraction)
      all.append(data)
    }
    
    return all
    
  }
  
}