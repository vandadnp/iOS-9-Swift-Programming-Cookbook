//
//  Automating_UI_Test_ScriptsUITests.swift
//  Automating UI Test ScriptsUITests
//
//  Created by Vandad on 7/6/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import Foundation
import XCTest

class Automating_UI_Test_ScriptsUITests: XCTestCase {
        
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
      
      let enteredString = "Hello, World!"
      let expectedString = enteredString.uppercaseString
      
      let app = XCUIApplication()
      let fullNameTextField = app.textFields["Full Name"]
      fullNameTextField.tap()
      fullNameTextField.typeText(enteredString)
      app.buttons["Capitalize"].tap()
      
      let lbl = app.staticTexts["Capitalized String"]
      XCTAssert(lbl.value as! String == expectedString)
      
    }
    
}
