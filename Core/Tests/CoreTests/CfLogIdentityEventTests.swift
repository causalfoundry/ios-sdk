//
//  File.swift
//  
//
//  Created by khushbu on 16/10/23.
//
//
//import Foundation
//
//
//import XCTest
//@testable import CasualFoundryCore // Replace with your app's module name
//
//class CfLogIdentityEventTests: XCTestCase {
//
//    func testCfLogIdentityEventInitialization() {
//        let identityEvent = CfLogIdentityEvent(identity_action: "login", app_user_id: "123", meta: nil, update_immediately: true)
//
//        XCTAssertEqual(identityEvent.identity_action, "login")
//        XCTAssertEqual(identityEvent.app_user_id, "123")
//        XCTAssertNil(identityEvent.meta)
//        XCTAssertTrue(identityEvent.update_immediately)
//    }
//
//    // Add more test cases as needed
//}
//
//class CfLogIdnetityBuilderTests: XCTestCase {
//
//    func testCfLogIdnetityBuilder() {
//        let builder = CfLogIdnetityBuilder()
//            .setIdentifyAction(identity_action: "login")
//            .setAppUserId(app_user_id: "test_user")
//            .setMeta(meta: nil)
//            .updateImmediately(update_immediately: true)
//
//        // Validate the builder methods and values
//
//        // Add more test cases as needed
//    }
//
//    // Add more test cases as needed
//}