//
//  Swiping_on_UI_ElementsUITests.swift
//  Swiping on UI ElementsUITests
//
//  Created by Vandad on 7/7/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import Foundation
import XCTest

class Swiping_on_UI_ElementsUITests: XCTestCase {
  
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
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    let app = XCUIApplication()
    let cells = app.cells
    XCTAssertEqual(cells.count, 10)
    app.cells.element(boundBy: 4).swipeLeft()
    app.buttons["Delete"].tap()
    XCTAssertEqual(cells.count, 9)
    
  }
  
}
