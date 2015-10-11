//
//  InterfaceController.swift
//  Watch Extension
//
//  Created by Vandad on 8/4/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import WatchKit
import Foundation

class InterfaceController: WKInterfaceController, NSURLSessionDelegate,
NSURLSessionDownloadDelegate {
  
  @IBOutlet var statusLbl: WKInterfaceLabel!
  
  var status: String = ""{
    didSet{
      dispatch_async(dispatch_get_main_queue()){[unowned self] in
        self.statusLbl.setText(self.status)
      }
    }
  }
  
  func URLSession(session: NSURLSession,
    downloadTask: NSURLSessionDownloadTask,
    didFinishDownloadingToURL location: NSURL) {
      
      let fm = NSFileManager()
      let url = try! fm.URLForDirectory(.DownloadsDirectory,
        inDomain: .UserDomainMask,
        appropriateForURL: location, create: true)
        .URLByAppendingPathComponent("file.txt")
      
      do{
        try fm.removeItemAtURL(url)
        try fm.moveItemAtURL(location, toURL: url)
        self.status = "Download finished"
      } catch let err{
        self.status = "Error = \(err)"
      }
      
      session.invalidateAndCancel()
      
  }
  
  func URLSession(session: NSURLSession,
    downloadTask: NSURLSessionDownloadTask, didWriteData bytesWritten: Int64,
    totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
    status = "Downloaded \(bytesWritten) bytes"
  }
  
  func URLSession(session: NSURLSession,
    downloadTask: NSURLSessionDownloadTask,
    didResumeAtOffset fileOffset: Int64, expectedTotalBytes: Int64) {
    status = "Resuming the download"
  }
  
  func URLSession(session: NSURLSession, task: NSURLSessionTask,
    didCompleteWithError error: NSError?) {
      if let e = error{
        status = "Completed with error = \(e)"
      } else {
        status = "Finished"
      }
  }
  
  func URLSession(session: NSURLSession,
    didBecomeInvalidWithError error: NSError?) {
      if let e = error{
        status = "Invalidated \(e)"
      } else {
        //no errors occurred, so that's alright
      }
  }
  
  @IBAction func download() {
    
    let url = NSURL(string: "http://localhost:8888/file.txt")!
    
    let id = "se.pixolity.app.backgroundtask"
    let conf = NSURLSessionConfiguration
      .backgroundSessionConfigurationWithIdentifier(id)
    
    let session = NSURLSession(configuration: conf, delegate: self,
      delegateQueue: NSOperationQueue())
    
    let request = NSURLRequest(URL: url)
    
    session.downloadTaskWithRequest(request).resume()
    
  }
  
}
