import Foundation

@testable import KenkaiSDKCore
import XCTest

class CfLogIdentityEventTests: XCTestCase {
    func testCfLogIdentityEventInitialization() {
        let identityEvent = CfLogIdentityEvent(identity_action: "login", app_user_id: "123", meta: nil, update_immediately: true, blocked_reason: "Blocked reason", blocked_remarks: "Blocked remarks")

        XCTAssertEqual(identityEvent.identity_action, "login")
        XCTAssertEqual(identityEvent.app_user_id, "123")
        XCTAssertNil(identityEvent.meta)
        XCTAssertTrue(identityEvent.update_immediately)
        XCTAssertEqual(identityEvent.blocked_reason, "Blocked reason")
        XCTAssertEqual(identityEvent.blocked_remarks, "Blocked remarks")
    }

    // Add more test cases as needed
}

class CfLogIdnetityBuilderTests: XCTestCase {
    func testCfLogIdnetityBuilder() {
        _ = CfLogIdentityBuilder()
            .setIdentifyAction(identity_action: "login")
            .setAppUserId(app_user_id: "test_user")
            .setBlockedReason(blocked_reason: "Blocked reason")
            .setBlockedRemarks(blocked_remarks: "Blocked remarks")
            .setMeta(meta: nil)
            .updateImmediately(update_immediately: true)

        // Validate the builder methods and values

        // Add more test cases as needed
    }

    // Add more test cases as needed
}
