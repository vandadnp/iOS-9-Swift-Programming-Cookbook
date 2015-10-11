//
//  ViewController.swift
//  Downloading and Preparing Remote Media for Playback
//
//  Created by Vandad on 8/3/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAssetDownloadDelegate {
  
  let url = NSURL(string: "http://localhost:8888/video.mp4")!
  let sessionId = "com.mycompany.background"
  let queue = NSOperationQueue()
  var task: AVAssetDownloadTask?
  var session: AVAssetDownloadURLSession?
  
  func URLSession(session: NSURLSession, task: NSURLSessionTask,
    didCompleteWithError error: NSError?) {
    //code this
  }
  
  func URLSession(session: NSURLSession,
    assetDownloadTask: AVAssetDownloadTask,
    didLoadTimeRange timeRange: CMTimeRange,
    totalTimeRangesLoaded loadedTimeRanges: [NSValue],
    timeRangeExpectedToLoad: CMTimeRange) {
    //code this
  }
  
  func URLSession(session: NSURLSession,
    assetDownloadTask: AVAssetDownloadTask,
    didResolveMediaSelection resolvedMediaSelection: AVMediaSelection) {
    
  }

  @IBAction func download() {
    
    let options = [AVURLAssetReferenceRestrictionsKey :
      AVAssetReferenceRestrictions.ForbidCrossSiteReference.rawValue]
    
    let asset = AVURLAsset(URL: url, options: options)
    
    let config = NSURLSessionConfiguration
      .backgroundSessionConfigurationWithIdentifier(sessionId)
    
    let session = AVAssetDownloadURLSession(configuration: config,
      assetDownloadDelegate: self, delegateQueue: queue)
    self.session = session
    
    let fm = NSFileManager()
    let destinationUrl = try! fm.URLForDirectory(.CachesDirectory,
      inDomain: .UserDomainMask, appropriateForURL: url, create: true)
      .URLByAppendingPathComponent("file.mp4")
    
    guard let task = session.assetDownloadTaskWithURLAsset(asset,
      destinationURL: destinationUrl, options: nil) else {
      print("Could not create the task")
      return
    }
    
    self.task = task
    
    task.resume()
    
  }
  
}

