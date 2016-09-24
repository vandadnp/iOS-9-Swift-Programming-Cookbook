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
  
}

class ComplicationController: NSObject, CLKComplicationDataSource {
  
  let dataProvider = DataProvider()
  
  func templateForData(_ data: Data) -> CLKComplicationTemplate{
    let template = CLKComplicationTemplateModularSmallRingText()
    template.textProvider = CLKSimpleTextProvider(text: data.hourAsStr)
    template.fillFraction = data.fraction
    template.ringStyle = .closed
    return template
  }
  
  func timelineEntryForData(_ data: Data) -> CLKComplicationTimelineEntry{
    let template = templateForData(data)
    return CLKComplicationTimelineEntry(date: data.date as Date,
      complicationTemplate: template)
  }
  
  func getSupportedTimeTravelDirections(
    for complication: CLKComplication,
    withHandler handler: @escaping (CLKComplicationTimeTravelDirections) -> Void) {
      handler([.forward, .backward])
  }
  
  func getTimelineStartDate(for complication: CLKComplication,
    withHandler handler: @escaping (Date?) -> Void) {
      handler(dataProvider.allDataForToday().first!.date as Date)
  }
  
  func getTimelineEndDate(for complication: CLKComplication,
    withHandler handler: @escaping (Date?) -> Void) {
    handler(dataProvider.allDataForToday().last!.date as Date?)
  }
  
  func getPrivacyBehavior(for complication: CLKComplication,
    withHandler handler: @escaping (CLKComplicationPrivacyBehavior) -> Void) {
    handler(.showOnLockScreen)
  }
  
  func getCurrentTimelineEntry(for complication: CLKComplication,
    withHandler handler: (@escaping (CLKComplicationTimelineEntry?) -> Void)) {
      
      if let data = dataProvider.allDataForToday().dataForNow(){
        handler(timelineEntryForData(data))
      } else {
        handler(nil)
      }
      
  }
  
  func getTimelineEntries(for complication: CLKComplication,
    before date: Date, limit: Int,
    withHandler handler: (@escaping ([CLKComplicationTimelineEntry]?) -> Void)) {
      
      let entries = dataProvider.allDataForToday().filter{
        date.compare($0.date as Date) == .orderedDescending
      }.map{
        self.timelineEntryForData($0)
      }
      
      handler(entries)
  }
  
  func getTimelineEntries(for complication: CLKComplication,
    after date: Date, limit: Int,
    withHandler handler: (@escaping ([CLKComplicationTimelineEntry]?) -> Void)) {
    
      let entries = dataProvider.allDataForToday().filter{
        date.compare($0.date as Date) == .orderedAscending
      }.map{
        self.timelineEntryForData($0)
      }
      
      handler(entries)
      
  }
  
  func getNextRequestedUpdateDate(handler: @escaping (Date?) -> Void) {
    handler(Date.endOfToday());
  }
  
  func getPlaceholderTemplate(for complication: CLKComplication,
    withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
      if let data = dataProvider.allDataForToday().dataForNow(){
        handler(templateForData(data))
      } else {
        handler(nil)
      }
  }
  
}
