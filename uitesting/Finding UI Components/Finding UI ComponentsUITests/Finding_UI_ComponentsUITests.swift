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
    let view = app.windows.childrenMatchingType(.Unknown)
    let innerView = view.childrenMatchingType(.Unknown)
    let btn = innerView.childrenMatchingType(.Button).elementBoundByIndex(0)
    XCTAssert(btn.exists)
    btn.tap()
  }
  
  func testExample2(){
    let app = XCUIApplication()
    
    let btn = app.windows.childrenMatchingType(.Unknown)
      .descendantsMatchingType(.Button).elementBoundByIndex(0)
    
    XCTAssert(btn.exists)
    btn.tap()
  }
  
  func testExample3(){
    let btn = XCUIApplication().buttons.elementBoundByIndex(0)
    XCTAssert(btn.exists)
    btn.tap()
  }
  
  func testExample4(){
    
    let mainView = XCUIApplication().windows.childrenMatchingType(.Unknown)
    
    let viewsWithButton = mainView.descendantsMatchingType(.Unknown)
      .containingType(.Button, identifier: nil)
    
    XCTAssert(viewsWithButton.count > 0)
    
    let btn = viewsWithButton.childrenMatchingType(.Button)
      .elementBoundByIndex(0)
    
    XCTAssert(btn.exists)
    
    btn.tap()
    
  }
  
  
  func testExample5(){
    
    let app = XCUIApplication()
    
    let btns = app.buttons.matchingPredicate(
      NSPredicate(format: "title like[c] 'Button'"))
    
    XCTAssert(btns.count >= 1)
    
    let btn = btns.elementBoundByIndex(0)
    
    XCTAssert(btn.exists)
    
  }
  
  func testExample6(){
    
    let app = XCUIApplication()
    
    let disabledBtns = app.buttons.containingPredicate(
      NSPredicate(format: "enabled == false"))
    
    XCTAssert(disabledBtns.count > 1)
    
    for n in 0..<disabledBtns.count{
      let btn = disabledBtns.elementBoundByIndex(n)
      XCTAssert(btn.exists)
    }
    
  }
  
  
}
