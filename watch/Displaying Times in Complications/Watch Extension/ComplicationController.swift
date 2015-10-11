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

extension CollectionType where Generator.Element : Pausable {
  
  func nextPause() -> Self.Generator.Element?{
    let now = NSDate()
    
    for pause in self{
      if now.compare(pause.date) == .OrderedAscending{
        return pause
      }
    }

    return nil
  }
  
}

class ComplicationController: NSObject, CLKComplicationDataSource {
  
  let dataProvider = DataProvider()
  
  func templateForPause(pause: PauseAtWork) -> CLKComplicationTemplate{
    
    guard let nextPause = dataProvider.allPausesToday().nextPause() else{
      let template = CLKComplicationTemplateModularLargeStandardBody()
      template.headerTextProvider = CLKSimpleTextProvider(text: "Next Break")
      template.body1TextProvider = CLKSimpleTextProvider(text: "None")
      return template
    }
    
    let template = CLKComplicationTemplateModularLargeTallBody()
    template.headerTextProvider = CLKSimpleTextProvider(text: nextPause.name)
    template.bodyTextProvider = CLKTimeTextProvider(date: nextPause.date)
    
    return template
  }
  
  func timelineEntryForPause(pause: PauseAtWork) ->
    CLKComplicationTimelineEntry{
    let template = templateForPause(pause)
    return CLKComplicationTimelineEntry(date: pause.date,
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
      handler(dataProvider.allPausesToday().first!.date)
  }
  
  func getTimelineEndDateForComplication(complication: CLKComplication,
    withHandler handler: (NSDate?) -> Void) {
    handler(dataProvider.allPausesToday().last!.date)
  }
  
  func getTimelineEntriesForComplication(complication: CLKComplication,
    beforeDate date: NSDate, limit: Int,
    withHandler handler: (([CLKComplicationTimelineEntry]?) -> Void)) {
      
      let entries = dataProvider.allPausesToday().filter{
        date.compare($0.date) == .OrderedDescending
      }.map{
        self.timelineEntryForPause($0)
      }
      
      handler(entries)
  }
  
  func getTimelineEntriesForComplication(complication: CLKComplication,
    afterDate date: NSDate, limit: Int,
    withHandler handler: (([CLKComplicationTimelineEntry]?) -> Void)) {
    
      let entries = dataProvider.allPausesToday().filter{
        date.compare($0.date) == .OrderedAscending
      }.map{
        self.timelineEntryForPause($0)
      }
      
      handler(entries)
      
  }
  
  func getCurrentTimelineEntryForComplication(complication: CLKComplication,
    withHandler handler: ((CLKComplicationTimelineEntry?) -> Void)) {
      
      if let pause = dataProvider.allPausesToday().nextPause(){
        handler(timelineEntryForPause(pause))
      } else {
        handler(nil)
      }
      
  }
  
  func getNextRequestedUpdateDateWithHandler(handler: (NSDate?) -> Void) {
    handler(NSDate().plus10Minutes());
  }
  
  func getPlaceholderTemplateForComplication(complication: CLKComplication,
    withHandler handler: (CLKComplicationTemplate?) -> Void) {
      if let pause = dataProvider.allPausesToday().nextPause(){
        handler(templateForPause(pause))
      } else {
        handler(nil)
      }
  }
  
}
