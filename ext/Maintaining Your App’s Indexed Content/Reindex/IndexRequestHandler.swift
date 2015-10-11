//
//  IndexRequestHandler.swift
//  Reindex
//
//  Created by Vandad on 7/1/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import CoreSpotlight
import UIKit

protocol Indexable{
  var id: String {get set}
  var title: String {get set}
  var description: String {get set}
  var url: NSURL? {get set}
  var thumbnail: UIImage? {get set}
}

struct Indexed : Indexable{
  //Indexable conformance
  var id: String
  var title: String
  var description: String
  var url: NSURL?
  var thumbnail: UIImage?
}

extension SequenceType where Generator.Element : Indexable{
  func allIds() -> [String]{
    var ids = [String]()
    for (_, v) in self.enumerate(){
      ids.append(v.id)
    }
    return ids
  }
}

class IndexRequestHandler: CSIndexExtensionRequestHandler {
  
  lazy var indexedItems: [Indexed] = {
    
    var items = [Indexed]()
    for n in 1...10{
      items.append(Indexed(id: "id \(n)", title: "Item \(n)",
        description: "Description \(n)", url: nil, thumbnail: nil))
    }
    return items
    
  }()
  
  override func searchableIndex(searchableIndex: CSSearchableIndex,
    reindexAllSearchableItemsWithAcknowledgementHandler
    acknowledgementHandler: () -> Void) {
      
      for _ in indexedItems{
        //TODO: you can index the item here.
      }
      
      //call this handler once you are done
      acknowledgementHandler()
  }
  
  override func searchableIndex(searchableIndex: CSSearchableIndex,
    reindexSearchableItemsWithIdentifiers identifiers: [String],
    acknowledgementHandler: () -> Void) {
      
      //get all the identifiers strings that we have
      let ourIds = indexedItems.allIds()
      
      //go through the items that we have and look for the given id
      var n = 0
      for i in identifiers{
        if let index = ourIds.indexOf(i){
          let _ = indexedItems[index]
          //TODO: reindex this item.
        }
        n++
      }
      
      acknowledgementHandler()
  }
  
}
