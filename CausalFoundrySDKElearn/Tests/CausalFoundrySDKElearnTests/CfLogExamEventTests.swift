@testable import CausalFoundrySDKCore
import XCTest

class CfLogExamEventTests: XCTestCase {
    var logExamEvent: CfLogExamEvent!

    override func setUp() {
        super.setUp()
        logExamEvent = CfLogExamEvent()
    }

    override func tearDown() {
        logExamEvent = nil
        super.tearDown()
    }

    func testSetExamId() {
        logExamEvent.setExamId("123")
        XCTAssertEqual(logExamEvent.examId, "123")
    }

    func testSetExamActionWithEnum() {
        logExamEvent.setExamAction(.start)
        XCTAssertEqual(logExamEvent.action, ExamAction.start.rawValue)
    }

    func testSetExamActionWithString() {
        logExamEvent.setExamAction("start")
        XCTAssertEqual(logExamEvent.action, "start")
    }

    func testSetDuration() {
        logExamEvent.setDuration(60)
        XCTAssertEqual(logExamEvent.durationValue, 60)
    }

    func testSetScore() {
        logExamEvent.setScore(90.5)
        XCTAssertEqual(logExamEvent.scoreValue, 90.5)
    }

    func testIsPassed() {
        logExamEvent.isPassed(true)
        XCTAssertEqual(logExamEvent.isPassed, true)
    }

    func testSetMeta() {
        logExamEvent.setMeta("Additional information")
        XCTAssertEqual(logExamEvent.meta as? String, "Additional information")
    }

    func testUpdateImmediately() {
        logExamEvent.updateImmediately(true)
        XCTAssertEqual(logExamEvent.updateImmediately, true)
    }

    func testBuildWithValidInputs() {
        logExamEvent.setExamId("123")
            .setExamAction("start")
            .setDuration(60)
            .setScore(90.5)
            .isPassed(true)
            .setMeta("Additional information")
            .updateImmediately(true)
            .build()

        // Add assertions based on your requirements
    }

    func testBuildWithMissingRequiredFields() {
        // Missing examId
        logExamEvent
            .setExamAction("start")
            .setDuration(60)
            .setScore(90.5)
            .isPassed(true)
            .setMeta("Additional information")
            .updateImmediately(true)

        // Add assertions to check for an exception or handle accordingly
    }
}
