//
//  SampleSwiftUITests.swift
//  SampleSwiftUITests
//
//  Created by Akira Hirakawa on 18/7/15.
//  Copyright © 2015 akirahrkw. All rights reserved.
//

import XCTest

class SampleSwiftUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()
    }
    
    override func tearDown() {

        super.tearDown()
    }

    func testPhoto() {
        let tablesQuery = XCUIApplication().tables
        tablesQuery.staticTexts["Photo Samples"].tap()
        tablesQuery.staticTexts["Selfies"].tap()
    }

    func testCreatePhoto() {
        let diceRoll = Int(arc4random_uniform(1000))
        let text = "Test Album \(diceRoll)"

        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery.staticTexts["Photo Samples"].tap()
        app.navigationBars["SampleSwift.PhotoIndexView"].buttons["Add"].tap()

        let collectionViewsQuery = app.alerts["New Album"].collectionViews
        collectionViewsQuery.textFields["Album Name"].typeText(text)
        collectionViewsQuery.buttons["Create"].tap()
        tablesQuery.staticTexts[text].tap()
    }
}
