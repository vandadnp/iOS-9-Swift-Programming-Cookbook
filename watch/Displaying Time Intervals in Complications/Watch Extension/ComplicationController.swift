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

extension CollectionType where Generator.Element : Timable {
  
  func nextMeeting() -> Self.Generator.Element?{
    let now = NSDate()
    
    for meeting in self{
      if now.compare(meeting.startDate) == .OrderedAscending{
        return meeting
      }
    }

    return nil
  }
  
}


class ComplicationController: NSObject, CLKComplicationDataSource {
  
  let dataProvider = DataProvider()
  
  func templateForMeeting(meeting: Meeting) -> CLKComplicationTemplate{
    
    let template = CLKComplicationTemplateModularLargeStandardBody()
    
    guard let nextMeeting = dataProvider.allMeetingsToday().nextMeeting() else{
      template.headerTextProvider = CLKSimpleTextProvider(text: "Next Break")
      template.body1TextProvider = CLKSimpleTextProvider(text: "None")
      return template
    }
    
    template.headerTextProvider =
      CLKTimeIntervalTextProvider(startDate: nextMeeting.startDate,
        endDate: nextMeeting.endDate)
      
    template.body1TextProvider =
      CLKSimpleTextProvider(text: nextMeeting.name,
        shortText: nextMeeting.shortName)
    
    template.body2TextProvider =
      CLKSimpleTextProvider(text: nextMeeting.location,
        shortText: nextMeeting.shortLocation)
    
    return template
  }
  
  func timelineEntryForMeeting(meeting: Meeting) -> CLKComplicationTimelineEntry{
    let template = templateForMeeting(meeting)
    
    let date = meeting.previous?.endDate ?? meeting.startDate
    return CLKComplicationTimelineEntry(date: date,
      complicationTemplate: template)
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
  
  func getTimelineStartDateForComplication(complication: CLKComplication,
    withHandler handler: (NSDate?) -> Void) {
      handler(dataProvider.allMeetingsToday().first!.startDate)
  }
  
  func getTimelineEndDateForComplication(complication: CLKComplication,
    withHandler handler: (NSDate?) -> Void) {
    handler(dataProvider.allMeetingsToday().last!.endDate)
  }
  
  func getTimelineEntriesForComplication(complication: CLKComplication,
    beforeDate date: NSDate, limit: Int,
    withHandler handler: (([CLKComplicationTimelineEntry]?) -> Void)) {
      
      let entries = dataProvider.allMeetingsToday().filter{
        date.compare($0.startDate) == .OrderedDescending
      }.map{
        self.timelineEntryForMeeting($0)
      }
      
      handler(entries)
  }
  
  func getTimelineEntriesForComplication(complication: CLKComplication,
    afterDate date: NSDate, limit: Int,
    withHandler handler: (([CLKComplicationTimelineEntry]?) -> Void)) {
    
      let entries = dataProvider.allMeetingsToday().filter{
        date.compare($0.startDate) == .OrderedAscending
      }.map{
        self.timelineEntryForMeeting($0)
      }
      
      handler(entries)
      
  }
  
  func getCurrentTimelineEntryForComplication(complication: CLKComplication,
    withHandler handler: ((CLKComplicationTimelineEntry?) -> Void)) {
      
      if let meeting = dataProvider.allMeetingsToday().nextMeeting(){
        handler(timelineEntryForMeeting(meeting))
      } else {
        handler(nil)
      }
      
  }
  
  func getNextRequestedUpdateDateWithHandler(handler: (NSDate?) -> Void) {
    handler(NSDate().plus10Minutes());
  }
  
  func getPlaceholderTemplateForComplication(complication: CLKComplication,
    withHandler handler: (CLKComplicationTemplate?) -> Void) {
      if let pause = dataProvider.allMeetingsToday().nextMeeting(){
        handler(templateForMeeting(pause))
      } else {
        handler(nil)
      }
  }
  
}
