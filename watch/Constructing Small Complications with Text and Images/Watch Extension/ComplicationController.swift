//
//  ComplicationController.swift
//  Watch Extension
//
//  Created by Vandad on 8/6/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import ClockKit

extension NSDate{
  
  class func endOfToday() -> NSDate{
    let cal = NSCalendar.currentCalendar()
    let units = NSCalendarUnit.Year.union(NSCalendarUnit.Month)
      .union(NSCalendarUnit.Day)
    let comps = cal.components(units, fromDate: NSDate())
    comps.hour = 23
    comps.minute = 59
    comps.second = 59
    return cal.dateFromComponents(comps)!
  }
  
}

class ComplicationController: NSObject, CLKComplicationDataSource {
  
  let dataProvider = DataProvider()
  
  func templateForData(data: Data) -> CLKComplicationTemplate{
    let template = CLKComplicationTemplateModularSmallRingText()
    template.textProvider = CLKSimpleTextProvider(text: data.hourAsStr)
    template.fillFraction = data.fraction
    template.ringStyle = .Closed
    return template
  }
  
  func timelineEntryForData(data: Data) -> CLKComplicationTimelineEntry{
    let template = templateForData(data)
    return CLKComplicationTimelineEntry(date: data.date,
      complicationTemplate: template)
  }
  
  func getSupportedTimeTravelDirectionsForComplication(
    complication: CLKComplication,
    withHandler handler: (CLKComplicationTimeTravelDirections) -> Void) {
      handler([.Forward, .Backward])
  }
  
  func getTimelineStartDateForComplication(complication: CLKComplication,
    withHandler handler: (NSDate?) -> Void) {
      handler(dataProvider.allDataForToday().first!.date)
  }
  
  func getTimelineEndDateForComplication(complication: CLKComplication,
    withHandler handler: (NSDate?) -> Void) {
    handler(dataProvider.allDataForToday().last!.date)
  }
  
  func getPrivacyBehaviorForComplication(complication: CLKComplication,
    withHandler handler: (CLKComplicationPrivacyBehavior) -> Void) {
    handler(.ShowOnLockScreen)
  }
  
  func getCurrentTimelineEntryForComplication(complication: CLKComplication,
    withHandler handler: ((CLKComplicationTimelineEntry?) -> Void)) {
      
      if let data = dataProvider.allDataForToday().dataForNow(){
        handler(timelineEntryForData(data))
      } else {
        handler(nil)
      }
      
  }
  
  func getTimelineEntriesForComplication(complication: CLKComplication,
    beforeDate date: NSDate, limit: Int,
    withHandler handler: (([CLKComplicationTimelineEntry]?) -> Void)) {
      
      let entries = dataProvider.allDataForToday().filter{
        date.compare($0.date) == .OrderedDescending
      }.map{
        self.timelineEntryForData($0)
      }
      
      handler(entries)
  }
  
  func getTimelineEntriesForComplication(complication: CLKComplication,
    afterDate date: NSDate, limit: Int,
    withHandler handler: (([CLKComplicationTimelineEntry]?) -> Void)) {
    
      let entries = dataProvider.allDataForToday().filter{
        date.compare($0.date) == .OrderedAscending
      }.map{
        self.timelineEntryForData($0)
      }
      
      handler(entries)
      
  }
  
  func getNextRequestedUpdateDateWithHandler(handler: (NSDate?) -> Void) {
    handler(NSDate.endOfToday());
  }
  
  func getPlaceholderTemplateForComplication(complication: CLKComplication,
    withHandler handler: (CLKComplicationTemplate?) -> Void) {
      if let data = dataProvider.allDataForToday().dataForNow(){
        handler(templateForData(data))
      } else {
        handler(nil)
      }
  }
  
}
