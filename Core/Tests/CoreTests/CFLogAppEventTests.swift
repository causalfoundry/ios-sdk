//
//  CFLogAppEventTests.swift
//  
//
//  Created by khushbu on 11/10/23.
//

import XCTest

@testable import CasualFoundryCore

class CFLogAppEventTests: XCTestCase {

    func testCFLogAppEventInitialization() {
        // Test CFLogAppEvent initialization
        let cfLogAppEvent = CFLogAppEvent(action: "SomeAction", meta: "SomeMeta", startTimeValue: 10, eventTimeValue: 100, update_immediately: true)

        XCTAssertEqual(cfLogAppEvent.action, "SomeAction")
        XCTAssertEqual(cfLogAppEvent.meta as? String, "SomeMeta")
        XCTAssertEqual(cfLogAppEvent.startTimeValue, 10)
        XCTAssertEqual(cfLogAppEvent.eventTimeValue, 100)
        XCTAssertEqual(cfLogAppEvent.update_immediately, true)
    }
}

class CFLogAppEventBuilderTests: XCTestCase {

    func testCFLogAppEventBuilder() {
        // Test CFLogAppEventBuilder
        let cfLogAppEventBuilder = CFLogAppEventBuilder()
            .setAppEvent(appAction: .appOpen)
            .setEventTime(event_time: 123456789)
            .setStartTime(start_time: 100)
            .setMeta(meta: "SomeMeta")
            .updateImmediately(update_immediately: false)

        // Build CFLogAppEvent instance
        cfLogAppEventBuilder.build()

        // Add assertions for CFLogAppEvent properties
        // For example:
        XCTAssertEqual(cfLogAppEventBuilder.action, "AppOpen")
        XCTAssertEqual(cfLogAppEventBuilder.eventTimeValue, 123456789)
        XCTAssertEqual(cfLogAppEventBuilder.startTimeValue, 100)
        XCTAssertEqual(cfLogAppEventBuilder.meta as? String, "SomeMeta")
        XCTAssertEqual(cfLogAppEventBuilder.update_immediately, false)
    }
}
