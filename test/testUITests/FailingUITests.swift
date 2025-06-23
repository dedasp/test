//
//  FailingUITests.swift
//  testUITests
//
//  Created by Test Suite
//

import XCTest

final class FailingUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor
    func testAlwaysFails() throws {
        // This test will always fail
        let app = XCUIApplication()
        app.launch()
        
        // Intentionally fail the test
        XCTFail("This test is designed to fail to demonstrate CI/CD failure handling")
    }
    
    @MainActor
    func testElementNotFound() throws {
        // This test will fail because it's looking for an element that doesn't exist
        let app = XCUIApplication()
        app.launch()
        
        // Try to find a button that doesn't exist in the app
        let nonExistentButton = app.buttons["NonExistentButton"]
        
        // This assertion will fail because the button doesn't exist
        XCTAssertTrue(nonExistentButton.exists, "Button should exist but it doesn't")
    }
    
    @MainActor
    func testIncorrectText() throws {
        // This test will fail due to incorrect text assertion
        let app = XCUIApplication()
        app.launch()
        
        // Assuming there's some text in the app, we'll assert it's something it's not
        let someTextElement = app.staticTexts.element(boundBy: 0)
        
        // This will fail if the app has any text, because we're asserting it's "WrongText"
        XCTAssertEqual(someTextElement.label, "WrongText", "Text should be 'WrongText' but it's not")
    }
    
    @MainActor
    func testTimeoutFailure() throws {
        // This test will fail due to timeout
        let app = XCUIApplication()
        app.launch()
        
        // Try to wait for an element that will never appear
        let neverAppearingElement = app.buttons["NeverAppearingButton"]
        
        // This will timeout and fail
        XCTAssertTrue(neverAppearingElement.waitForExistence(timeout: 2), "Element should appear within 2 seconds")
    }
} 