//
//  ComplicationController.swift
//  Watch Extension
//
//  Created by Vandad on 8/6/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import ClockKit

extension Date{
  
  static func endOfToday() -> Date{
    let cal = Calendar.current
    let units = NSCalendar.Unit.year.union(NSCalendar.Unit.month)
      .union(NSCalendar.Unit.day)
    var comps = (cal as NSCalendar).components(units, from: Date())
    comps.hour = 23
    comps.minute = 59
    comps.second = 59
    return cal.date(from: comps)!
  }
  
  func plus10Minutes() -> Date{
    return self.addingTimeInterval(10 * 60)
  }
  
}


extension Collection where Iterator.Element : OnRailable {
  
  func nextTrain() -> Iterator.Element?{
    let now = Date()
    for d in self{
      if now.compare(d.departureTime as Date) == .orderedAscending{
        return d
      }
    }
    return nil
  }
  
}

class ComplicationController: NSObject, CLKComplicationDataSource {
  
  let dataProvider = DataProvider()
  
  func templateForTrain(_ train: Train) -> CLKComplicationTemplate{
    let template = CLKComplicationTemplateModularLargeStandardBody()
    template.headerTextProvider = CLKSimpleTextProvider(text: "Next train")
    
    template.body1TextProvider =
      CLKRelativeDateTextProvider(date: train.departureTime as Date,
        style: .offset,
        units: NSCalendar.Unit.hour.union(.minute))
    
    let secondLine = "\(train.service) - \(train.type)"
    
    template.body2TextProvider = CLKSimpleTextProvider(text: secondLine,
      shortText: train.type.rawValue)
    
    return template
  }
  
  func timelineEntryForTrain(_ train: Train) -> CLKComplicationTimelineEntry{
    let template = templateForTrain(train)
    return CLKComplicationTimelineEntry(date: train.departureTime as Date,
      complicationTemplate: template)
  }
  
  func getTimelineStartDate(for complication: CLKComplication,
    withHandler handler: @escaping (Date?) -> Void) {
      handler(dataProvider.allTrainsForToday().first!.departureTime as Date)
  }
  
  func getTimelineEndDate(for complication: CLKComplication,
    withHandler handler: @escaping (Date?) -> Void) {
    handler(dataProvider.allTrainsForToday().last!.departureTime as Date?)
  }
  
  func getSupportedTimeTravelDirections(
    for complication: CLKComplication,
    withHandler handler: @escaping (CLKComplicationTimeTravelDirections) -> Void) {
      handler([.forward, .backward])
  }
  
  func getPrivacyBehavior(for complication: CLKComplication,
    withHandler handler: @escaping (CLKComplicationPrivacyBehavior) -> Void) {
    handler(.showOnLockScreen)
  }
  
  func getTimelineEntries(for complication: CLKComplication,
    before date: Date, limit: Int,
    withHandler handler: (@escaping ([CLKComplicationTimelineEntry]?) -> Void)) {
      
      let entries = dataProvider.allTrainsForToday().filter{
        date.compare($0.departureTime as Date) == .orderedDescending
      }.map{
        self.timelineEntryForTrain($0)
      }
      
      handler(entries)
  }
  
  func getTimelineEntries(for complication: CLKComplication,
    after date: Date, limit: Int,
    withHandler handler: (@escaping ([CLKComplicationTimelineEntry]?) -> Void)) {
    
      let entries = dataProvider.allTrainsForToday().filter{
        date.compare($0.departureTime as Date) == .orderedAscending
      }.map{
        self.timelineEntryForTrain($0)
      }
      
      handler(entries)
      
  }
  
  func getCurrentTimelineEntry(for complication: CLKComplication,
    withHandler handler: (@escaping (CLKComplicationTimelineEntry?) -> Void)) {
      
      if let train = dataProvider.allTrainsForToday().nextTrain(){
        handler(timelineEntryForTrain(train))
      } else {
        handler(nil)
      }
      
  }
  
  func getNextRequestedUpdateDate(handler: @escaping (Date?) -> Void) {
    handler(Date.endOfToday());
  }
  
  func getPlaceholderTemplate(for complication: CLKComplication,
    withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
      if let data = dataProvider.allTrainsForToday().nextTrain(){
        handler(templateForTrain(data))
      } else {
        handler(nil)
      }
  }
  
}
