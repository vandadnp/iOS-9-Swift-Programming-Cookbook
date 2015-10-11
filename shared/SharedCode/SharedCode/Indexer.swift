//
//  Indexer.swift
//  SharedCode
//
//  Created by Vandad on 7/1/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import Foundation
import CoreSpotlight
import MobileCoreServices

public class Indexer{
  
  public init(){
    //
  }
  
  public func doIndex(){
    
    //delete the existing indexed items
    CSSearchableIndex.defaultSearchableIndex()
      .deleteAllSearchableItemsWithCompletionHandler {err in
        if let err = err{
          print("Error in deleting \(err)")
        }
    }
    
    let attr = CSSearchableItemAttributeSet(
      itemContentType: kUTTypeText as String)
    
    attr.title = "My item"
    attr.contentDescription = "My description"
    attr.path = "http://reddit.com"
    attr.contentURL = NSURL(string: attr.path!)!
    attr.keywords = ["reddit", "subreddit", "today", "i", "learned"]
    
    if let url = NSBundle(forClass: self.dynamicType)
      .URLForResource("Icon", withExtension: "png"){
        attr.thumbnailData = NSData(contentsOfURL: url)
    }
    
    //searchable item
    let item = CSSearchableItem(
      uniqueIdentifier: attr.contentURL!.absoluteString,
      domainIdentifier: nil, attributeSet: attr)
    
    let cal = NSCalendar.currentCalendar()
    
    //our content expires in 20 seconds
    item.expirationDate = cal.dateFromComponents(cal
      .componentsInTimeZone(cal.timeZone, fromDate:
        NSDate().dateByAddingTimeInterval(20)))
    
    //now index the item
    CSSearchableIndex.defaultSearchableIndex()
      .indexSearchableItems([item]) {err in
        guard err == nil else{
          print("Error occurred \(err!)")
          return
        }
        
        print("We successfully indexed the item. Will expire in 20 seconds")
        
    }
    
  }
  
}