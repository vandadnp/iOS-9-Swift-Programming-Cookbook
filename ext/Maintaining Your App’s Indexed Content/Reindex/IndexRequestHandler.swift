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
  var url: URL? {get set}
  var thumbnail: UIImage? {get set}
}

struct Indexed : Indexable{
  //Indexable conformance
  var id: String
  var title: String
  var description: String
  var url: URL?
  var thumbnail: UIImage?
}

extension Sequence where Iterator.Element : Indexable{
  func allIds() -> [String]{
    var ids = [String]()
    for (_, v) in self.enumerated(){
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
  
  override func searchableIndex(_ searchableIndex: CSSearchableIndex,
    reindexAllSearchableItemsWithAcknowledgementHandler
    acknowledgementHandler: @escaping () -> Void) {
      
      for _ in indexedItems{
        //TODO: you can index the item here.
      }
      
      //call this handler once you are done
      acknowledgementHandler()
  }
  
  override func searchableIndex(_ searchableIndex: CSSearchableIndex,
    reindexSearchableItemsWithIdentifiers identifiers: [String],
    acknowledgementHandler: @escaping () -> Void) {
      
      //get all the identifiers strings that we have
      let ourIds = indexedItems.allIds()
      
      //go through the items that we have and look for the given id
      var n = 0
      for i in identifiers{
        if let index = ourIds.index(of: i){
          let _ = indexedItems[index]
          //TODO: reindex this item.
        }
        n += 1
      }
      
      acknowledgementHandler()
  }
  
}
