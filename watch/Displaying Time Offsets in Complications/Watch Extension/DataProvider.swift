//
//  DataProvider.swift
//  Constructing Small Complications with Text and Images
//
//  Created by Vandad on 8/7/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import Foundation

enum TrainType : String{
  case HighSpeed = "High Speed"
  case Commuter = "Commuter"
  case Coastal = "Coastal"
}

enum TrainCompany : String{
  case SJ = "SJ"
  case Southern = "Souther"
  case OldRail = "Old Rail"
}

protocol OnRailable{
  var type: TrainType {get}
  var company: TrainCompany {get}
  var service: String {get}
  var departureTime: Date {get}
}

struct Train : OnRailable{
  let type: TrainType
  let company: TrainCompany
  let service: String
  let departureTime: Date
}

struct DataProvider{
  
  func allTrainsForToday() -> [Train]{
    
    var all = [Train]()
    
    let now = Date()
    let cal = Calendar.current
    let units = NSCalendar.Unit.year.union(.month).union(.day)
    var comps = (cal as NSCalendar).components(units, from: now)
    
    //first train
    comps.hour = 6
    comps.minute = 30
    comps.second = 0
    let date1 = cal.date(from: comps)!
    all.append(Train(type: .Commuter, company: .SJ,
      service: "3296", departureTime: date1))
    
    //second train
    comps.hour = 9
    comps.minute = 57
    let date2 = cal.date(from: comps)!
    all.append(Train(type: .HighSpeed, company: .Southern,
      service: "2307", departureTime: date2))
    
    //third train
    comps.hour = 12
    comps.minute = 22
    let date3 = cal.date(from: comps)!
    all.append(Train(type: .Coastal, company: .OldRail,
      service: "3206", departureTime: date3))
    
    //fourth train
    comps.hour = 15
    comps.minute = 45
    let date4 = cal.date(from: comps)!
    all.append(Train(type: .HighSpeed, company: .SJ,
      service: "3703", departureTime: date4))
    
    //fifth train
    comps.hour = 18
    comps.minute = 19
    let date5 = cal.date(from: comps)!
    all.append(Train(type: .Coastal, company: .Southern,
      service: "8307", departureTime: date5))
    
    //sixth train
    comps.hour = 22
    comps.minute = 11
    let date6 = cal.date(from: comps)!
    all.append(Train(type: .Commuter, company: .OldRail,
      service: "6802", departureTime: date6))
    
    return all
    
  }
  
}
