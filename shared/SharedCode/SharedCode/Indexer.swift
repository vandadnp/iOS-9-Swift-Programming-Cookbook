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

open class Indexer{
  
  public init(){
    //
  }
  
  open func doIndex(){
    
    //delete the existing indexed items
    CSSearchableIndex.default()
      .deleteAllSearchableItems {err in
        if let err = err{
          print("Error in deleting \(err)")
        }
    }
    
    let attr = CSSearchableItemAttributeSet(
      itemContentType: kUTTypeText as String)
    
    attr.title = "My item"
    attr.contentDescription = "My description"
    attr.path = "http://reddit.com"
    attr.contentURL = URL(string: attr.path!)!
    attr.keywords = ["reddit", "subreddit", "today", "i", "learned"]
    
    if let url = Bundle(for: type(of: self))
      .url(forResource: "Icon", withExtension: "png"){
        attr.thumbnailData = try? Data(contentsOf: url)
    }
    
    //searchable item
    let item = CSSearchableItem(
      uniqueIdentifier: attr.contentURL!.absoluteString,
      domainIdentifier: nil, attributeSet: attr)
    
    let cal = Calendar.current
    
    //our content expires in 20 seconds
    item.expirationDate = cal.date(from: cal
      .dateComponents(in: cal.timeZone, from:
        Date().addingTimeInterval(20)))
    
    //now index the item
    CSSearchableIndex.default()
      .indexSearchableItems([item]) {err in
        guard err == nil else{
          print("Error occurred \(err!)")
          return
        }
        
        print("We successfully indexed the item. Will expire in 20 seconds")
        
    }
    
  }
  
}
