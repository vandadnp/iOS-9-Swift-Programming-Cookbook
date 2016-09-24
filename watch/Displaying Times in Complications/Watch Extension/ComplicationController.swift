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

extension Collection where Iterator.Element : Pausable {
  
  func nextPause() -> Self.Iterator.Element?{
    let now = Date()
    
    for pause in self{
      if now.compare(pause.date as Date) == .orderedAscending{
        return pause
      }
    }

    return nil
  }
  
}

class ComplicationController: NSObject, CLKComplicationDataSource {
  
  let dataProvider = DataProvider()
  
  func templateForPause(_ pause: PauseAtWork) -> CLKComplicationTemplate{
    
    guard let nextPause = dataProvider.allPausesToday().nextPause() else{
      let template = CLKComplicationTemplateModularLargeStandardBody()
      template.headerTextProvider = CLKSimpleTextProvider(text: "Next Break")
      template.body1TextProvider = CLKSimpleTextProvider(text: "None")
      return template
    }
    
    let template = CLKComplicationTemplateModularLargeTallBody()
    template.headerTextProvider = CLKSimpleTextProvider(text: nextPause.name)
    template.bodyTextProvider = CLKTimeTextProvider(date: nextPause.date as Date)
    
    return template
  }
  
  func timelineEntryForPause(_ pause: PauseAtWork) ->
    CLKComplicationTimelineEntry{
    let template = templateForPause(pause)
    return CLKComplicationTimelineEntry(date: pause.date as Date,
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
      handler(dataProvider.allPausesToday().first!.date as Date)
  }
  
  func getTimelineEndDate(for complication: CLKComplication,
    withHandler handler: @escaping (Date?) -> Void) {
    handler(dataProvider.allPausesToday().last!.date as Date?)
  }
  
  func getTimelineEntries(for complication: CLKComplication,
    before date: Date, limit: Int,
    withHandler handler: (@escaping ([CLKComplicationTimelineEntry]?) -> Void)) {
      
      let entries = dataProvider.allPausesToday().filter{
        date.compare($0.date as Date) == .orderedDescending
      }.map{
        self.timelineEntryForPause($0)
      }
      
      handler(entries)
  }
  
  func getTimelineEntries(for complication: CLKComplication,
    after date: Date, limit: Int,
    withHandler handler: (@escaping ([CLKComplicationTimelineEntry]?) -> Void)) {
    
      let entries = dataProvider.allPausesToday().filter{
        date.compare($0.date as Date) == .orderedAscending
      }.map{
        self.timelineEntryForPause($0)
      }
      
      handler(entries)
      
  }
  
  func getCurrentTimelineEntry(for complication: CLKComplication,
    withHandler handler: (@escaping (CLKComplicationTimelineEntry?) -> Void)) {
      
      if let pause = dataProvider.allPausesToday().nextPause(){
        handler(timelineEntryForPause(pause))
      } else {
        handler(nil)
      }
      
  }
  
  func getNextRequestedUpdateDate(handler: @escaping (Date?) -> Void) {
    handler(Date().plus10Minutes());
  }
  
  func getPlaceholderTemplate(for complication: CLKComplication,
    withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
      if let pause = dataProvider.allPausesToday().nextPause(){
        handler(templateForPause(pause))
      } else {
        handler(nil)
      }
  }
  
}
