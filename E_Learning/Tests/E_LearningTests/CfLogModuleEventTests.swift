import XCTest
@testable import CasualFoundryCore

class CfLogModuleEventTests: XCTestCase {

    var logModuleEvent: CfLogModuleEvent!

    override func setUp() {
        super.setUp()
        logModuleEvent = CfLogModuleEvent()
    }

    override func tearDown() {
        logModuleEvent = nil
        super.tearDown()
    }

    func testSetModuleId() {
        logModuleEvent.setModuleId("456")
        XCTAssertEqual(logModuleEvent.moduleId, "456")
    }

    func testSetModuleProgress() {
        logModuleEvent.setModuleProgress(50)
        XCTAssertEqual(logModuleEvent.progress, 50)
    }

    func testSetModuleActionWithEnum() {
        logModuleEvent.setModuleAction(.view)
        XCTAssertEqual(logModuleEvent.action, ModuleLogAction.view.rawValue)
    }

    func testSetModuleActionWithString() {
        logModuleEvent.setModuleAction("view")
        XCTAssertEqual(logModuleEvent.action, "view")
    }

    func testSetMeta() {
        logModuleEvent.setMeta("Additional information")
        XCTAssertEqual(logModuleEvent.meta as? String, "Additional information")
    }

    func testUpdateImmediately() {
        logModuleEvent.updateImmediately(true)
        XCTAssertEqual(logModuleEvent.updateImmediately, true)
    }

    func testBuildWithValidInputs() {
        logModuleEvent.setModuleId("456")
            .setModuleProgress(50)
            .setModuleAction("view")
            .setMeta("Additional information")
            .updateImmediately(true)
            .build()

        // Add assertions based on your requirements
    }

    func testBuildWithMissingRequiredFields() {
        // Missing moduleId
        logModuleEvent
            .setModuleProgress(50)
            .setModuleAction("view")
            .setMeta("Additional information")
            .updateImmediately(true)

        // Add assertions to check for an exception or handle accordingly
    }
}

