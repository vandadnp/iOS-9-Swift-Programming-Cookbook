//
//  InterfaceController.swift
//  Watch Extension
//
//  Created by Vandad on 8/4/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import WatchKit
import Foundation

class InterfaceController: WKInterfaceController, URLSessionDelegate,
URLSessionDownloadDelegate {
  
  @IBOutlet var statusLbl: WKInterfaceLabel!
  
  var status: String = ""{
    didSet{
      DispatchQueue.main.async{[unowned self] in
        self.statusLbl.setText(self.status)
      }
    }
  }
  
  func urlSession(_ session: URLSession,
    downloadTask: URLSessionDownloadTask,
    didFinishDownloadingTo location: URL) {
      
      let fm = FileManager()
      let url = try! fm.url(for: .downloadsDirectory,
        in: .userDomainMask,
        appropriateFor: location, create: true)
        .appendingPathComponent("file.txt")
      
      do{
        try fm.removeItem(at: url)
        try fm.moveItem(at: location, to: url)
        self.status = "Download finished"
      } catch let err{
        self.status = "Error = \(err)"
      }
      
      session.invalidateAndCancel()
      
  }
  
  func urlSession(_ session: URLSession,
    downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64,
    totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
    status = "Downloaded \(bytesWritten) bytes"
  }
  
  func urlSession(_ session: URLSession,
    downloadTask: URLSessionDownloadTask,
    didResumeAtOffset fileOffset: Int64, expectedTotalBytes: Int64) {
    status = "Resuming the download"
  }
  
  func urlSession(_ session: URLSession, task: URLSessionTask,
    didCompleteWithError error: Error?) {
      if let e = error{
        status = "Completed with error = \(e)"
      } else {
        status = "Finished"
      }
  }
  
  func urlSession(_ session: URLSession,
    didBecomeInvalidWithError error: Error?) {
      if let e = error{
        status = "Invalidated \(e)"
      } else {
        //no errors occurred, so that's alright
      }
  }
  
  @IBAction func download() {
    
    let url = URL(string: "http://localhost:8888/file.txt")!
    
    let id = "se.pixolity.app.backgroundtask"
    let conf = URLSessionConfiguration
      .background(withIdentifier: id)
    
    let session = Foundation.URLSession(configuration: conf, delegate: self,
      delegateQueue: OperationQueue())
    
    let request = URLRequest(url: url)
    
    session.downloadTask(with: request).resume()
    
  }
  
}
