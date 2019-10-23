//
//  SPHTestUITests.swift
//  SPHTestUITests
//
//  Created by John Harries on 15/10/19.
//  Copyright © 2019 John Harries. All rights reserved.
//

import XCTest

class SPHTestUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testLaunchApp() {
        
        let app = XCUIApplication()
        app.launch()
        
        let tablesQuery = app.tables
        XCTAssertTrue(tablesQuery.staticTexts["2004-Q3 [0.000384]"].exists)
    }
    
    func testTapOnDecreasedArrow() {

        let app = XCUIApplication()
        app.launch()

        let tablesQuery = app.tables
        tablesQuery.cells.containing(.staticText, identifier:"2013-Q1 [5.807872]").images["iconDropArrowActive"].tap()
        XCTAssertTrue(app.alerts.scrollViews.otherElements.staticTexts["Mobile usage volume had been decreased"].exists)
    }
}
