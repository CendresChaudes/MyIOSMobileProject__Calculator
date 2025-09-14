//
//  CalculatorUITests.swift
//  CalculatorUITests
//
//  Created by Роман on 04.09.2025.
//

import XCTest

final class CalculatorUITests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
    }

    override func tearDown() {}

    @MainActor
    func testExample() {
        let test = "TEST"

        XCTAssertEqual(test, "TEST")
    }
}
