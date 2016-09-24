//
//  ComplicationController.swift
//  Watch Extension
//
//  Created by Vandad on 8/6/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import ClockKit


class ComplicationController: NSObject, CLKComplicationDataSource {
  
  // MARK: - Timeline Configuration
  
  func getSupportedTimeTravelDirections(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimeTravelDirections) -> Void) {
    handler([.forward, .backward])
  }
  
  func getTimelineStartDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
    handler(nil)
  }
  
  func getTimelineEndDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
    handler(nil)
  }
  
  func getPrivacyBehavior(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationPrivacyBehavior) -> Void) {
    handler(.showOnLockScreen)
  }
  
  // MARK: - Timeline Population
  
  func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: (@escaping (CLKComplicationTimelineEntry?) -> Void)) {
    // Call the handler with the current timeline entry
    handler(nil)
  }
  
  func getTimelineEntries(for complication: CLKComplication, before date: Date, limit: Int, withHandler handler: (@escaping ([CLKComplicationTimelineEntry]?) -> Void)) {
    // Call the handler with the timeline entries prior to the given date
    handler(nil)
  }
  
  func getTimelineEntries(for complication: CLKComplication, after date: Date, limit: Int, withHandler handler: (@escaping ([CLKComplicationTimelineEntry]?) -> Void)) {
    // Call the handler with the timeline entries after to the given date
    handler(nil)
  }
  
  // MARK: - Update Scheduling
  
  func getNextRequestedUpdateDate(handler: @escaping (Date?) -> Void) {
    // Call the handler with the date when you would next like to be given the opportunity to update your complication content
    handler(nil);
  }
  
  // MARK: - Placeholder Templates
  
  func getPlaceholderTemplate(for complication: CLKComplication,
    withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
    let temp = CLKComplicationTemplateModularSmallSimpleText()
    temp.textProvider = CLKSimpleTextProvider(text: "22")
    handler(temp)
  }
  
}
