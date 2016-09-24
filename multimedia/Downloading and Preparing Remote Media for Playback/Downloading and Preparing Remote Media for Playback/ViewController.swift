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
  
  let url = URL(string: "http://localhost:8888/video.mp4")!
  let sessionId = "com.mycompany.background"
  let queue = OperationQueue()
  var task: AVAssetDownloadTask?
  var session: AVAssetDownloadURLSession?
  
  func urlSession(_ session: URLSession, task: URLSessionTask,
    didCompleteWithError error: Error?) {
    //code this
  }
  
  func urlSession(_ session: URLSession,
    assetDownloadTask: AVAssetDownloadTask,
    didLoad timeRange: CMTimeRange,
    totalTimeRangesLoaded loadedTimeRanges: [NSValue],
    timeRangeExpectedToLoad: CMTimeRange) {
    //code this
  }
  
  func urlSession(_ session: URLSession,
    assetDownloadTask: AVAssetDownloadTask,
    didResolve resolvedMediaSelection: AVMediaSelection) {
    
  }

  @IBAction func download() {
    
    let options = [AVURLAssetReferenceRestrictionsKey :
      AVAssetReferenceRestrictions.forbidCrossSiteReference.rawValue]
    
    let asset = AVURLAsset(url: url, options: options)
    
    let config = URLSessionConfiguration
      .background(withIdentifier: sessionId)
    
    let session = AVAssetDownloadURLSession(configuration: config,
      assetDownloadDelegate: self, delegateQueue: queue)
    self.session = session
    
    let fm = FileManager()
    let destinationUrl = try! fm.url(for: .cachesDirectory,
      in: .userDomainMask, appropriateFor: url, create: true)
      .appendingPathComponent("file.mp4")
    
    guard let task = session.makeAssetDownloadTask(asset: asset,
      destinationURL: destinationUrl, options: nil) else {
      print("Could not create the task")
      return
    }
    
    self.task = task
    
    task.resume()
    
  }
  
}

