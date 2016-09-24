//
//  ComplicationController.swift
//  Watch Extension
//
//  Created by Vandad on 8/6/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import ClockKit

extension Date{
  func plus10Minutes() -> Date{
    return self.addingTimeInterval(10 * 60)
  }
}

extension Array{
  var second : Iterator.Element?{
    return self.count >= 1 ? self[1] : nil
  }
  var third : Iterator.Element?{
    return self.count >= 2 ? self[2] : nil
  }
}

func minimum<T : Comparable>(_ x: T, _ y: T) -> T{
  return x < y ? x : y
}

extension Collection where Iterator.Element : Holidayable {
  
  //may contain less than 3 holidays
  func nextThreeHolidays() -> Array<Self.Iterator.Element>{
    let now = Date()

    let orderedArray = Array(self.filter{
      now.compare($0.date as Date) == .orderedAscending
    })
    
    let result = Array(orderedArray[0..<minimum(orderedArray.count , 3)])
    
    return result
  }
  
}

class ComplicationController: NSObject, CLKComplicationDataSource {
  
  let dataProvider = DataProvider()
  
  func templateForHoliday(_ holiday: Holiday) -> CLKComplicationTemplate{
    
    let next3Holidays = dataProvider.allHolidays().nextThreeHolidays()
    
    let headerTitle = "Next 3 Holidays"
    
    guard next3Holidays.count > 0 else{
      let template = CLKComplicationTemplateModularLargeStandardBody()
      template.headerTextProvider = CLKSimpleTextProvider(text: headerTitle)
      template.body1TextProvider = CLKSimpleTextProvider(text: "Sorry!")
      return template
    }
    
    let dateUnits = NSCalendar.Unit.month.union(.day)
    let template = CLKComplicationTemplateModularLargeColumns()
    
    //first holiday
    if let firstHoliday = next3Holidays.first{
      template.row1Column1TextProvider =
        CLKSimpleTextProvider(text: firstHoliday.name)
      template.row1Column2TextProvider =
        CLKDateTextProvider(date: firstHoliday.date as Date, units: dateUnits)
    }
    
    //second holiday
    if let secondHoliday = next3Holidays.second{
      template.row2Column1TextProvider =
        CLKSimpleTextProvider(text: secondHoliday.name)
      template.row2Column2TextProvider =
        CLKDateTextProvider(date: secondHoliday.date as Date, units: dateUnits)
    }
    
    //third holiday
    if let thirdHoliday = next3Holidays.third{
      template.row3Column1TextProvider =
        CLKSimpleTextProvider(text: thirdHoliday.name)
      template.row3Column2TextProvider =
        CLKDateTextProvider(date: thirdHoliday.date as Date, units: dateUnits)
    }
    
    return template
  }
  
  func timelineEntryForHoliday(_ holiday: Holiday) ->
    CLKComplicationTimelineEntry{
    let template = templateForHoliday(holiday)
    return CLKComplicationTimelineEntry(date: holiday.date as Date,
      complicationTemplate: template)
  }
  
  func getTimelineStartDate(for complication: CLKComplication,
    withHandler handler: @escaping (Date?) -> Void) {
      handler(dataProvider.allHolidays().first!.date as Date)
  }
  
  func getTimelineEndDate(for complication: CLKComplication,
    withHandler handler: @escaping (Date?) -> Void) {
    handler(dataProvider.allHolidays().last!.date as Date?)
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
      
      let entries = dataProvider.allHolidays().filter{
        date.compare($0.date as Date) == .orderedDescending
      }.map{
        self.timelineEntryForHoliday($0)
      }
      
      handler(entries)
  }
  
  func getTimelineEntries(for complication: CLKComplication,
    after date: Date, limit: Int,
    withHandler handler: (@escaping ([CLKComplicationTimelineEntry]?) -> Void)) {
    
      let entries = dataProvider.allHolidays().filter{
        date.compare($0.date as Date) == .orderedAscending
      }.map{
        self.timelineEntryForHoliday($0)
      }
      
      handler(entries)
      
  }
  
  func getCurrentTimelineEntry(for complication: CLKComplication,
    withHandler handler: (@escaping (CLKComplicationTimelineEntry?) -> Void)) {
      
      if let first = dataProvider.allHolidays().nextThreeHolidays().first{
        handler(timelineEntryForHoliday(first))
      } else {
        handler(nil)
      }
      
  }
  
  func getNextRequestedUpdateDate(handler: @escaping (Date?) -> Void) {
    handler(Date().plus10Minutes());
  }
  
  func getPlaceholderTemplate(for complication: CLKComplication,
    withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
      if let holiday = dataProvider.allHolidays().nextThreeHolidays().first{
        handler(templateForHoliday(holiday))
      } else {
        handler(nil)
      }
  }
  
}
