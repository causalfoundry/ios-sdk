//
//  CfLogChwModuleEventTests.swift
//  
//
//  Created by khushbu on 26/10/23.
//

import XCTest

final class CfLogChwModuleEventBuilderTests: XCTestCase {

    func testSetChwModuleEventWithEnum() {
        // Create a builder instance
        let builder = CfLogChwModuleEventBuilder()

        // Set the CHW module type using an enum
        builder.setChwModuleEvent(.assessment)

        // Verify that the module type is correctly set
        XCTAssertEqual(builder.moduleType, "assessment")
    }

    func testSetChwModuleEventWithString() {
        // Create a builder instance
        let builder = CfLogChwModuleEventBuilder()

        // Set the CHW module type using a string
        builder.setChwModuleEvent("enrolment")

        // Verify that the module type is correctly set
        XCTAssertEqual(builder.moduleType, "enrolment")
    }

    func testSetMeta() {
        // Create a builder instance
        let builder = CfLogChwModuleEventBuilder()

        // Set the meta information
        builder.setMeta(["key": "value"])

        // Verify that the meta information is correctly set
        XCTAssertEqual(builder.meta as? [String: String], ["key": "value"])
    }

    func testUpdateImmediately() {
        // Create a builder instance
        let builder = CfLogChwModuleEventBuilder()

        // Set the updateImmediately flag
        builder.updateImmediately(true)

        // Verify that the updateImmediately flag is correctly set
        XCTAssertTrue(builder.updateImmediately)
    }

    func testBuildSuccess() {
        // Create a builder instance
        let builder = CfLogChwModuleEventBuilder()

        // Set required values
        builder.setChwModuleEvent(.someEnumValue)

        // Build and track the event
        builder.build()

        // You can add assertions here to verify that the event is tracked successfully.
    }

    func testBuildFailure() {
        // Create a builder instance
        let builder = CfLogChwModuleEventBuilder()

        // Attempt to build without setting required values

        // Build and track the event
        builder.build()

    }
}
