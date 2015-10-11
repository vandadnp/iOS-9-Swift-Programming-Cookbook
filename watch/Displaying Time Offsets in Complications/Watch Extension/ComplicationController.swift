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
  
  func plus10Minutes() -> NSDate{
    return self.dateByAddingTimeInterval(10 * 60)
  }
  
}


extension CollectionType where Generator.Element : OnRailable {
  
  func nextTrain() -> Generator.Element?{
    let now = NSDate()
    for d in self{
      if now.compare(d.departureTime) == .OrderedAscending{
        return d
      }
    }
    return nil
  }
  
}

class ComplicationController: NSObject, CLKComplicationDataSource {
  
  let dataProvider = DataProvider()
  
  func templateForTrain(train: Train) -> CLKComplicationTemplate{
    let template = CLKComplicationTemplateModularLargeStandardBody()
    template.headerTextProvider = CLKSimpleTextProvider(text: "Next train")
    
    template.body1TextProvider =
      CLKRelativeDateTextProvider(date: train.departureTime,
        style: .Offset,
        units: NSCalendarUnit.Hour.union(.Minute))
    
    let secondLine = "\(train.service) - \(train.type)"
    
    template.body2TextProvider = CLKSimpleTextProvider(text: secondLine,
      shortText: train.type.rawValue)
    
    return template
  }
  
  func timelineEntryForTrain(train: Train) -> CLKComplicationTimelineEntry{
    let template = templateForTrain(train)
    return CLKComplicationTimelineEntry(date: train.departureTime,
      complicationTemplate: template)
  }
  
  func getTimelineStartDateForComplication(complication: CLKComplication,
    withHandler handler: (NSDate?) -> Void) {
      handler(dataProvider.allTrainsForToday().first!.departureTime)
  }
  
  func getTimelineEndDateForComplication(complication: CLKComplication,
    withHandler handler: (NSDate?) -> Void) {
    handler(dataProvider.allTrainsForToday().last!.departureTime)
  }
  
  func getSupportedTimeTravelDirectionsForComplication(
    complication: CLKComplication,
    withHandler handler: (CLKComplicationTimeTravelDirections) -> Void) {
      handler([.Forward, .Backward])
  }
  
  func getPrivacyBehaviorForComplication(complication: CLKComplication,
    withHandler handler: (CLKComplicationPrivacyBehavior) -> Void) {
    handler(.ShowOnLockScreen)
  }
  
  func getTimelineEntriesForComplication(complication: CLKComplication,
    beforeDate date: NSDate, limit: Int,
    withHandler handler: (([CLKComplicationTimelineEntry]?) -> Void)) {
      
      let entries = dataProvider.allTrainsForToday().filter{
        date.compare($0.departureTime) == .OrderedDescending
      }.map{
        self.timelineEntryForTrain($0)
      }
      
      handler(entries)
  }
  
  func getTimelineEntriesForComplication(complication: CLKComplication,
    afterDate date: NSDate, limit: Int,
    withHandler handler: (([CLKComplicationTimelineEntry]?) -> Void)) {
    
      let entries = dataProvider.allTrainsForToday().filter{
        date.compare($0.departureTime) == .OrderedAscending
      }.map{
        self.timelineEntryForTrain($0)
      }
      
      handler(entries)
      
  }
  
  func getCurrentTimelineEntryForComplication(complication: CLKComplication,
    withHandler handler: ((CLKComplicationTimelineEntry?) -> Void)) {
      
      if let train = dataProvider.allTrainsForToday().nextTrain(){
        handler(timelineEntryForTrain(train))
      } else {
        handler(nil)
      }
      
  }
  
  func getNextRequestedUpdateDateWithHandler(handler: (NSDate?) -> Void) {
    handler(NSDate.endOfToday());
  }
  
  func getPlaceholderTemplateForComplication(complication: CLKComplication,
    withHandler handler: (CLKComplicationTemplate?) -> Void) {
      if let data = dataProvider.allTrainsForToday().nextTrain(){
        handler(templateForTrain(data))
      } else {
        handler(nil)
      }
  }
  
}
