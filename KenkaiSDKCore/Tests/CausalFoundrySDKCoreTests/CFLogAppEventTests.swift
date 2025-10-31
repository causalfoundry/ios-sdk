//
//  CFLogAppEventTests.swift
//
//
//  Created by khushbu on 11/10/23.
//

import XCTest

@testable import KenkaiSDKCore

class CFLogAppEventTests: XCTestCase {
    var builder: CFLogAppEventBuilder!

    override func setUp() {
        super.setUp()
        // Create an instance of CFLogAppEventBuilder before each test
        builder = CFLogAppEventBuilder()
    }

    override func tearDown() {
        // Clean up after each test
        builder = nil
        super.tearDown()
    }

    func testSetAppEventWithEnum() {
        // Test setting the app event with an enum
        _ = builder.setAppEvent(appAction: .open)
        XCTAssertEqual(builder.action, AppAction.open.rawValue)
    }

    func testSetAppEventWithString() {
        // Test setting the app event with a valid string
        _ = builder.setAppEvent(appAction: .open)
        XCTAssertEqual(builder.action, AppAction.open.rawValue)
    }

//    func testSetAppEventWithInvalidString() {
//        // Test setting the app event with an invalid string
//        // This should throw an exception
//        XCTAssertThrowsError(builder.setAppEvent(appAction:"actionopen"))
//    }

    func testSetEventTime() {
        // Test setting the event time
        _ = builder.setEventTime(event_time: 1_234_567_890)
        XCTAssertEqual(builder.eventTimeValue, 1_234_567_890)
    }

    func testSetStartTime() {
        // Test setting the start time
        _ = builder.setStartTime(start_time: 1000)
        XCTAssertEqual(builder.startTimeValue, 1000)
    }

    func testSetMeta() {
        // Test setting the meta
        _ = builder.setMeta(meta: ["key": "value"])
        XCTAssertEqual(builder.meta as? [String: String], ["key": "value"])
    }

    func testUpdateImmediately() {
        // Test setting updateImmediately
        _ = builder.updateImmediately(update_immediately: true)
        XCTAssertTrue(builder.update_immediately)
    }

    func testBuild() {
        // Test the build method

        // Set required properties
        builder.setAppEvent(appAction: .open)
        builder.setEventTime(event_time: 1_234_567_890)
        builder.setStartTime(start_time: 1000)
        builder.updateImmediately(update_immediately: false)

        // You can add assertions to verify the behavior of the build method
        // For example, you can check if it calls IngestAPIHandler.shared.ingestTrackAPI correctly.

        builder.build()

        // Add your assertions here
    }
}
