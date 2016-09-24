//
//  RequestHandler.swift
//  SharedLink
//
//  Created by Vandad on 7/1/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import Foundation

class RequestHandler: NSObject, NSExtensionRequestHandling {
  
  func beginRequest(with context: NSExtensionContext) {
    let extensionItem = NSExtensionItem()
    
    extensionItem.userInfo = [
      "uniqueIdentifier": "uniqueIdentifierForSampleItem",
      "urlString": "http://reddit.com/r/askreddit",
      "date": Date()
    ]
    
    extensionItem.attributedTitle = NSAttributedString(string: "Reddit")
    
    extensionItem.attributedContentText = NSAttributedString(
      string: "AskReddit, one of the best subreddits there is")
    
    guard let img = Bundle.main.url(forResource: "ExtIcon",
      withExtension: "png") else {
        context.completeRequest(returningItems: nil, completionHandler: nil)
        return
    }
    
    extensionItem.attachments = [NSItemProvider(contentsOf: img)!]
    
    context.completeRequest(returningItems: [extensionItem], completionHandler: nil)
  }
  
}
