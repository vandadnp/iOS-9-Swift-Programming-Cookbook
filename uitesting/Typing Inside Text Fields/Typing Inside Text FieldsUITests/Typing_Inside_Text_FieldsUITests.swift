//
//  Typing_Inside_Text_FieldsUITests.swift
//  Typing Inside Text FieldsUITests
//
//  Created by Vandad on 7/7/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import Foundation
import XCTest

class Typing_Inside_Text_FieldsUITests: XCTestCase {
  
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
    let myText = app.textFields["myText"]
    myText.tap()
    
    let text1 = "Hello, World!"
    
    myText.typeText(text1)
    myText.typeText(XCUIKeyboardKeyDelete)
    app.typeText(XCUIKeyboardKeyReturn)
    
    XCTAssertEqual((myText.value as! String).characters.count,
      text1.characters.count - 1)
    
  }
  
}
