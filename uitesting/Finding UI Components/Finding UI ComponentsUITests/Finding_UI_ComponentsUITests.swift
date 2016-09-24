//
//  Finding_UI_ComponentsUITests.swift
//  Finding UI ComponentsUITests
//
//  Created by Vandad on 7/7/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import Foundation
import XCTest

class Finding_UI_ComponentsUITests: XCTestCase {
  
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
  
  func testExample1() {
    let app = XCUIApplication()
    let view = app.windows.children(matching: .other)
    let innerView = view.children(matching: .other)
    let btn = innerView.children(matching: .button).element(boundBy: 0)
    XCTAssert(btn.exists)
    btn.tap()
  }
  
  func testExample2(){
    let app = XCUIApplication()
    
    let btn = app.windows.children(matching: .other)
      .descendants(matching: .button).element(boundBy: 0)
    
    XCTAssert(btn.exists)
    btn.tap()
  }
  
  func testExample3(){
    let btn = XCUIApplication().buttons.element(boundBy: 0)
    XCTAssert(btn.exists)
    btn.tap()
  }
  
  func testExample4(){
    
    let mainView = XCUIApplication().windows.children(matching: .other)
    
    let viewsWithButton = mainView.descendants(matching: .other)
      .containing(.button, identifier: nil)
    
    XCTAssert(viewsWithButton.count > 0)
    
    let btn = viewsWithButton.children(matching: .button)
      .element(boundBy: 0)
    
    XCTAssert(btn.exists)
    
    btn.tap()
    
  }
  
  
  func testExample5(){
    
    let app = XCUIApplication()
    
    let btns = app.buttons.matching(
      NSPredicate(format: "title like[c] 'Button'"))
    
    XCTAssert(btns.count >= 1)
    
    let btn = btns.element(boundBy: 0)
    
    XCTAssert(btn.exists)
    
  }
  
  func testExample6(){
    
    let app = XCUIApplication()
    
    let disabledBtns = app.buttons.containing(
      NSPredicate(format: "enabled == false"))
    
    XCTAssert(disabledBtns.count > 1)
    
    for n in 0..<disabledBtns.count{
      let btn = disabledBtns.element(boundBy: n)
      XCTAssert(btn.exists)
    }
    
  }
  
  
}
