//
//  ComplicationController.swift
//  Watch Extension
//
//  Created by Vandad on 8/6/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import ClockKit

extension NSDate{
  func plus10Minutes() -> NSDate{
    return self.dateByAddingTimeInterval(10 * 60)
  }
}

extension Array{
  var second : Generator.Element?{
    return self.count >= 1 ? self[1] : nil
  }
  var third : Generator.Element?{
    return self.count >= 2 ? self[2] : nil
  }
}

extension CollectionType where Generator.Element : Holidayable {
  
  //may contain less than 3 holidays
  func nextThreeHolidays() -> Array<Self.Generator.Element>{
    let now = NSDate()

    let orderedArray = Array(self.filter{
      now.compare($0.date) == .OrderedAscending
    })
    
    let result = Array(orderedArray[0..<min(orderedArray.count , 3)])
    
    return result
  }
  
}

class ComplicationController: NSObject, CLKComplicationDataSource {
  
  let dataProvider = DataProvider()
  
  func templateForHoliday(holiday: Holiday) -> CLKComplicationTemplate{
    
    let next3Holidays = dataProvider.allHolidays().nextThreeHolidays()
    
    let headerTitle = "Next 3 Holidays"
    
    guard next3Holidays.count > 0 else{
      let template = CLKComplicationTemplateModularLargeStandardBody()
      template.headerTextProvider = CLKSimpleTextProvider(text: headerTitle)
      template.body1TextProvider = CLKSimpleTextProvider(text: "Sorry!")
      return template
    }
    
    let dateUnits = NSCalendarUnit.Month.union(.Day)
    let template = CLKComplicationTemplateModularLargeColumns()
    
    //first holiday
    if let firstHoliday = next3Holidays.first{
      template.row1Column1TextProvider =
        CLKSimpleTextProvider(text: firstHoliday.name)
      template.row1Column2TextProvider =
        CLKDateTextProvider(date: firstHoliday.date, units: dateUnits)
    }
    
    //second holiday
    if let secondHoliday = next3Holidays.second{
      template.row2Column1TextProvider =
        CLKSimpleTextProvider(text: secondHoliday.name)
      template.row2Column2TextProvider =
        CLKDateTextProvider(date: secondHoliday.date, units: dateUnits)
    }
    
    //third holiday
    if let thirdHoliday = next3Holidays.third{
      template.row3Column1TextProvider =
        CLKSimpleTextProvider(text: thirdHoliday.name)
      template.row3Column2TextProvider =
        CLKDateTextProvider(date: thirdHoliday.date, units: dateUnits)
    }
    
    return template
  }
  
  func timelineEntryForHoliday(holiday: Holiday) ->
    CLKComplicationTimelineEntry{
    let template = templateForHoliday(holiday)
    return CLKComplicationTimelineEntry(date: holiday.date,
      complicationTemplate: template)
  }
  
  func getTimelineStartDateForComplication(complication: CLKComplication,
    withHandler handler: (NSDate?) -> Void) {
      handler(dataProvider.allHolidays().first!.date)
  }
  
  func getTimelineEndDateForComplication(complication: CLKComplication,
    withHandler handler: (NSDate?) -> Void) {
    handler(dataProvider.allHolidays().last!.date)
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
      
      let entries = dataProvider.allHolidays().filter{
        date.compare($0.date) == .OrderedDescending
      }.map{
        self.timelineEntryForHoliday($0)
      }
      
      handler(entries)
  }
  
  func getTimelineEntriesForComplication(complication: CLKComplication,
    afterDate date: NSDate, limit: Int,
    withHandler handler: (([CLKComplicationTimelineEntry]?) -> Void)) {
    
      let entries = dataProvider.allHolidays().filter{
        date.compare($0.date) == .OrderedAscending
      }.map{
        self.timelineEntryForHoliday($0)
      }
      
      handler(entries)
      
  }
  
  func getCurrentTimelineEntryForComplication(complication: CLKComplication,
    withHandler handler: ((CLKComplicationTimelineEntry?) -> Void)) {
      
      if let first = dataProvider.allHolidays().nextThreeHolidays().first{
        handler(timelineEntryForHoliday(first))
      } else {
        handler(nil)
      }
      
  }
  
  func getNextRequestedUpdateDateWithHandler(handler: (NSDate?) -> Void) {
    handler(NSDate().plus10Minutes());
  }
  
  func getPlaceholderTemplateForComplication(complication: CLKComplication,
    withHandler handler: (CLKComplicationTemplate?) -> Void) {
      if let holiday = dataProvider.allHolidays().nextThreeHolidays().first{
        handler(templateForHoliday(holiday))
      } else {
        handler(nil)
      }
  }
  
}
