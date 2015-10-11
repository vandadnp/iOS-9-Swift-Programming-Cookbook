//
//  RequestHandler.swift
//  SharedLink
//
//  Created by Vandad on 7/1/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import Foundation

class RequestHandler: NSObject, NSExtensionRequestHandling {
  
  func beginRequestWithExtensionContext(context: NSExtensionContext) {
    let extensionItem = NSExtensionItem()
    
    extensionItem.userInfo = [
      "uniqueIdentifier": "uniqueIdentifierForSampleItem",
      "urlString": "http://reddit.com/r/askreddit",
      "date": NSDate()
    ]
    
    extensionItem.attributedTitle = NSAttributedString(string: "Reddit")
    
    extensionItem.attributedContentText = NSAttributedString(
      string: "AskReddit, one of the best subreddits there is")
    
    guard let img = NSBundle.mainBundle().URLForResource("ExtIcon",
      withExtension: "png") else {
        context.completeRequestReturningItems(nil, completionHandler: nil)
        return
    }
    
    extensionItem.attachments = [NSItemProvider(contentsOfURL: img)!]
    
    context.completeRequestReturningItems([extensionItem], completionHandler: nil)
  }
  
}
