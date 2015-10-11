//
//  Tapping_on_UI_ElementsUITests.swift
//  Tapping on UI ElementsUITests
//
//  Created by Vandad on 7/8/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import Foundation
import XCTest

class Tapping_on_UI_ElementsUITests: XCTestCase {
  
  override func setUp() {
    super.setUp()
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    continueAfterFailure = false
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    XCUIApplication().launch()
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  func testExample() {

    let app = XCUIApplication()
    let view = app.descendantsMatchingType(.Unknown)["myView"]
    
    XCTAssert(view.exists)
    XCTAssert(view.value as! String == "untapped")
    
    view.twoFingerTap()
    
    XCTAssert(view.value as! String == "tapped")
    
  }
  
}
