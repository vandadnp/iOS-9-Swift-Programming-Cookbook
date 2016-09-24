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

extension Collection where Iterator.Element : Timable {
  
  func nextMeeting() -> Self.Iterator.Element?{
    let now = Date()
    
    for meeting in self{
      if now.compare(meeting.startDate as Date) == .orderedAscending{
        return meeting
      }
    }

    return nil
  }
  
}


class ComplicationController: NSObject, CLKComplicationDataSource {
  
  let dataProvider = DataProvider()
  
  func templateForMeeting(_ meeting: Meeting) -> CLKComplicationTemplate{
    
    let template = CLKComplicationTemplateModularLargeStandardBody()
    
    guard let nextMeeting = dataProvider.allMeetingsToday().nextMeeting() else{
      template.headerTextProvider = CLKSimpleTextProvider(text: "Next Break")
      template.body1TextProvider = CLKSimpleTextProvider(text: "None")
      return template
    }
    
    template.headerTextProvider =
      CLKTimeIntervalTextProvider(start: nextMeeting.startDate as Date,
        end: nextMeeting.endDate as Date)
      
    template.body1TextProvider =
      CLKSimpleTextProvider(text: nextMeeting.name,
        shortText: nextMeeting.shortName)
    
    template.body2TextProvider =
      CLKSimpleTextProvider(text: nextMeeting.location,
        shortText: nextMeeting.shortLocation)
    
    return template
  }
  
  func timelineEntryForMeeting(_ meeting: Meeting) -> CLKComplicationTimelineEntry{
    let template = templateForMeeting(meeting)
    
    let date = meeting.previous?.endDate ?? meeting.startDate
    return CLKComplicationTimelineEntry(date: date as Date,
      complicationTemplate: template)
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
  
  func getTimelineStartDate(for complication: CLKComplication,
    withHandler handler: @escaping (Date?) -> Void) {
      handler(dataProvider.allMeetingsToday().first!.startDate as Date)
  }
  
  func getTimelineEndDate(for complication: CLKComplication,
    withHandler handler: @escaping (Date?) -> Void) {
    handler(dataProvider.allMeetingsToday().last!.endDate as Date?)
  }
  
  func getTimelineEntries(for complication: CLKComplication,
    before date: Date, limit: Int,
    withHandler handler: (@escaping ([CLKComplicationTimelineEntry]?) -> Void)) {
      
      let entries = dataProvider.allMeetingsToday().filter{
        date.compare($0.startDate as Date) == .orderedDescending
      }.map{
        self.timelineEntryForMeeting($0)
      }
      
      handler(entries)
  }
  
  func getTimelineEntries(for complication: CLKComplication,
    after date: Date, limit: Int,
    withHandler handler: (@escaping ([CLKComplicationTimelineEntry]?) -> Void)) {
    
      let entries = dataProvider.allMeetingsToday().filter{
        date.compare($0.startDate as Date) == .orderedAscending
      }.map{
        self.timelineEntryForMeeting($0)
      }
      
      handler(entries)
      
  }
  
  func getCurrentTimelineEntry(for complication: CLKComplication,
    withHandler handler: (@escaping (CLKComplicationTimelineEntry?) -> Void)) {
      
      if let meeting = dataProvider.allMeetingsToday().nextMeeting(){
        handler(timelineEntryForMeeting(meeting))
      } else {
        handler(nil)
      }
      
  }
  
  func getNextRequestedUpdateDate(handler: @escaping (Date?) -> Void) {
    handler(Date().plus10Minutes());
  }
  
  func getPlaceholderTemplate(for complication: CLKComplication,
    withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
      if let pause = dataProvider.allMeetingsToday().nextMeeting(){
        handler(templateForMeeting(pause))
      } else {
        handler(nil)
      }
  }
  
}
