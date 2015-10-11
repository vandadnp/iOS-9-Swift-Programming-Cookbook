//
//  DataProvider.swift
//  Constructing Small Complications with Text and Images
//
//  Created by Vandad on 8/7/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import Foundation

protocol Timable{
  var name: String {get}
  var shortName: String {get}
  var location: String {get}
  var shortLocation: String {get}
  var startDate: NSDate {get}
  var endDate: NSDate {get}
  var previous: Timable? {get}
}

struct Meeting : Timable{
  let name: String
  let shortName: String
  let location: String
  let shortLocation: String
  let startDate: NSDate
  let endDate: NSDate
  let previous: Timable?
}

struct DataProvider{
  
  func allMeetingsToday() -> [Meeting]{
    
    var all = [Meeting]()
    
    let oneHour: NSTimeInterval = 1 * 60.0 * 60
    
    let now = NSDate()
    let cal = NSCalendar.currentCalendar()
    let units = NSCalendarUnit.Year.union(.Month).union(.Day)
    let comps = cal.components(units, fromDate: now)
    comps.calendar = cal
    comps.minute = 30
    
    comps.hour = 11
    let meeting1 = Meeting(name: "Brunch with Sarah", shortName: "Brunch",
      location: "Stockholm Central", shortLocation: "Central",
      startDate: comps.date!,
      endDate: comps.date!.dateByAddingTimeInterval(oneHour), previous: nil)
    all.append(meeting1)
    
    comps.minute = 30
    comps.hour = 14
    let meeting2 = Meeting(name: "Lunch with Gabriella", shortName: "Lunch",
      location: "At home", shortLocation: "Home",
      startDate: comps.date!,
      endDate: comps.date!.dateByAddingTimeInterval(oneHour),
      previous: meeting1)
    all.append(meeting2)
    
    comps.minute = 0
    comps.hour = 16
    let meeting3 = Meeting(name: "Snack with Leif", shortName: "Snack",
      location: "Flags Cafe", shortLocation: "Flags",
      startDate: comps.date!,
      endDate: comps.date!.dateByAddingTimeInterval(oneHour),
      previous: meeting2)
    all.append(meeting3)
    
    comps.hour = 17
    let meeting4 = Meeting(name: "Dinner with Family", shortName: "Dinner",
      location: "At home", shortLocation: "Home",
      startDate: comps.date!,
      endDate: comps.date!.dateByAddingTimeInterval(oneHour),
      previous: meeting3)
    all.append(meeting4)
    
    return all
    
  }
  
}