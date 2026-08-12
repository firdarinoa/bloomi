//
//  BloomiUITests.swift
//  BloomiUITests
//
//  Created by Firda Sahidi on 11/08/2026.
//

import XCTest

final class BloomiUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testAddingMeasurementShowsRowInList() {
        let app = XCUIApplication()
        app.launch()

        app.navigationBars["Bloomi"].buttons["Add Measurement"].tap()

        let weightField = app.textFields.element(boundBy: 0)
        weightField.tap()
        weightField.typeText("70.5")

        app.navigationBars["New Measurement"].buttons["Save"].tap()

        XCTAssertTrue(app.staticTexts["70.5 kg"].waitForExistence(timeout: 5))
    }

    func testCancellingAddDoesNotCreateEntry() {
        let app = XCUIApplication()
        app.launch()

        let initialRowCount = app.tables.cells.count

        app.navigationBars["Bloomi"].buttons["Add Measurement"].tap()
        app.navigationBars["New Measurement"].buttons["Cancel"].tap()

        XCTAssertEqual(app.tables.cells.count, initialRowCount)
    }
}
