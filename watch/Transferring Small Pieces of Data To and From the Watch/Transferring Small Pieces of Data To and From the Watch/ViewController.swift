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
URLSessionDownloadDelegate {
  
  /** Called when all delegate callbacks for the previously selected watch has occurred. The session can be re-activated for the now selected watch using activateSession. */
  @available(iOS 9.3, *)
  public func sessionDidDeactivate(_ session: WCSession) {
    
  }
  
  
  /** Called when the session can no longer be used to modify or add any new transfers and, all interactive messages will be cancelled, but delegate callbacks for background transfers can still occur. This will happen when the selected watch is being changed. */
  @available(iOS 9.3, *)
  public func sessionDidBecomeInactive(_ session: WCSession) {
    
  }

  
  /** Called when the session has completed activation. If session state is WCSessionActivationStateNotActivated there will be an error with more details. */
  @available(iOS 9.3, *)
  public func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    
  }

  
  @IBOutlet var statusLbl: UILabel!
  @IBOutlet var sendBtn: UIButton!
  @IBOutlet var downloadBtn: UIButton!
  @IBOutlet var reachabilityStatusLbl: UILabel!
  
  var people: [String : AnyObject]?{
    didSet{
      DispatchQueue.main.async{
        self.updateSendButton()
      }
    }
  }
  
  func updateSendButton(){
    sendBtn.isEnabled = isReachable && isDownloadFinished && people != nil
  }
  
  var isReachable = false{
    didSet{
      DispatchQueue.main.async{
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
      DispatchQueue.main.async{
        self.updateSendButton()
      }
    }
  }
  
  var status: String?{
    get{return self.statusLbl.text}
    set{
      DispatchQueue.main.async{
        self.statusLbl.text = newValue
      }
    }
  }
  
  @IBAction func download() {
    
    //if loading HTTP content, make sure you have disabled ATS 
    //for that domain
    let url = URL(string: "http://localhost:8888/people.json")!
    let req = URLRequest(url: url)
    let id = "se.pixolity.app.backgroundtask"
    
    let conf = URLSessionConfiguration
      .background(withIdentifier: id)
    
    let sess = Foundation.URLSession(configuration: conf, delegate: self,
      delegateQueue: OperationQueue())
      
    sess.downloadTask(with: req).resume()
  }
  
  func urlSession(_ session: URLSession, task: URLSessionTask,
    didCompleteWithError error: Error?) {
    
      if error != nil{
        status = "Error happened"
        isDownloadFinished = false
      }
      
      session.finishTasksAndInvalidate()
      
  }
  
  func urlSession(_ session: URLSession,
    downloadTask: URLSessionDownloadTask,
    didFinishDownloadingTo location: URL){
      
      isDownloadFinished = true
      
      //got the data, parse as JSON
      let fm = FileManager()
      let url = try! fm.url(for: .downloadsDirectory,
        in: .userDomainMask,
        appropriateFor: location,
        create: true).appendingPathComponent("file.json")
      
      do {try fm.removeItem(at: url)} catch {}
      
      do{
        try fm.moveItem(at: location, to: url)
      } catch {
        status = "Could not save the file"
        return
      }
      
      //now read the file from url
      guard let data = try? Data(contentsOf: url) else{
        status = "Could not read the file"
        return
      }
      
      do{
        let json = try JSONSerialization.jsonObject(with: data,
        options: .allowFragments) as! [String : AnyObject]
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
    
    let session = WCSession.default()
    
    do{
      try session.updateApplicationContext(people)
      status = "Successfully updated the app context"
    } catch {
      status = "Failed to update the app context"
    }
    
    
  }
  
  func sessionReachabilityDidChange(_ session: WCSession) {
    isReachable = session.isReachable
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    guard WCSession.isSupported() else{
      status = "Sessions are not supported"
      return
    }
    
    let session = WCSession.default()
    session.delegate = self
    session.activate()
    isReachable = session.isReachable
    
  }

}

