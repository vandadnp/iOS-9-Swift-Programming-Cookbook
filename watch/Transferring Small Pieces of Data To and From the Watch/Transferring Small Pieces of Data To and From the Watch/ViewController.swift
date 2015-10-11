//
//  ViewController.swift
//  Transferring Small Pieces of Data To and From the Watch
//
//  Created by Vandad on 8/5/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import UIKit
import WatchConnectivity

class ViewController: UIViewController, WCSessionDelegate,
NSURLSessionDownloadDelegate {
  
  @IBOutlet var statusLbl: UILabel!
  @IBOutlet var sendBtn: UIButton!
  @IBOutlet var downloadBtn: UIButton!
  @IBOutlet var reachabilityStatusLbl: UILabel!
  
  var people: [String : AnyObject]?{
    didSet{
      dispatch_async(dispatch_get_main_queue()){
        self.updateSendButton()
      }
    }
  }
  
  func updateSendButton(){
    sendBtn.enabled = isReachable && isDownloadFinished && people != nil
  }
  
  var isReachable = false{
    didSet{
      dispatch_async(dispatch_get_main_queue()){
        self.updateSendButton()
        if self.isReachable{
          self.reachabilityStatusLbl.text = "Watch is reachable"
        } else {
          self.reachabilityStatusLbl.text = "Watch is not reachable"
        }
      }
    }
  }
  
  var isDownloadFinished = false{
    didSet{
      dispatch_async(dispatch_get_main_queue()){
        self.updateSendButton()
      }
    }
  }
  
  var status: String?{
    get{return self.statusLbl.text}
    set{
      dispatch_async(dispatch_get_main_queue()){
        self.statusLbl.text = newValue
      }
    }
  }
  
  @IBAction func download() {
    
    //if loading HTTP content, make sure you have disabled ATS 
    //for that domain
    let url = NSURL(string: "http://localhost:8888/people.json")!
    let req = NSURLRequest(URL: url)
    let id = "se.pixolity.app.backgroundtask"
    
    let conf = NSURLSessionConfiguration
      .backgroundSessionConfigurationWithIdentifier(id)
    
    let sess = NSURLSession(configuration: conf, delegate: self,
      delegateQueue: NSOperationQueue())
      
    sess.downloadTaskWithRequest(req).resume()
  }
  
  func URLSession(session: NSURLSession, task: NSURLSessionTask,
    didCompleteWithError error: NSError?) {
    
      if error != nil{
        status = "Error happened"
        isDownloadFinished = false
      }
      
      session.finishTasksAndInvalidate()
      
  }
  
  func URLSession(session: NSURLSession,
    downloadTask: NSURLSessionDownloadTask,
    didFinishDownloadingToURL location: NSURL){
      
      isDownloadFinished = true
      
      //got the data, parse as JSON
      let fm = NSFileManager()
      let url = try! fm.URLForDirectory(.DownloadsDirectory,
        inDomain: .UserDomainMask,
        appropriateForURL: location,
        create: true).URLByAppendingPathComponent("file.json")
      
      do {try fm.removeItemAtURL(url)} catch {}
      
      do{
        try fm.moveItemAtURL(location, toURL: url)
      } catch {
        status = "Could not save the file"
        return
      }
      
      //now read the file from url
      guard let data = NSData(contentsOfURL: url) else{
        status = "Could not read the file"
        return
      }
      
      do{
        let json = try NSJSONSerialization.JSONObjectWithData(data,
        options: .AllowFragments) as! [String : AnyObject]
        self.people = json
        status = "Successfully downloaded and parsed the file"
      } catch{
        status = "Could not read the file as json"
      }
      
  }
  
  @IBAction func send() {
    
    guard let people = self.people else{
      status = "People object is not available. Redownload?"
      return
    }
    
    let session = WCSession.defaultSession()
    
    do{
      try session.updateApplicationContext(people)
      status = "Successfully updated the app context"
    } catch {
      status = "Failed to update the app context"
    }
    
    
  }
  
  func sessionReachabilityDidChange(session: WCSession) {
    isReachable = session.reachable
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    guard WCSession.isSupported() else{
      status = "Sessions are not supported"
      return
    }
    
    let session = WCSession.defaultSession()
    session.delegate = self
    session.activateSession()
    isReachable = session.reachable
    
  }

}

