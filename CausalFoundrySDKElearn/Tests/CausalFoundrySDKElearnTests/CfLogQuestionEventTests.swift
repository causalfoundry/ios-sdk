
@testable import CausalFoundrySDKCore
import XCTest

class CfLogQuestionEventTests: XCTestCase {
    var logQuestionEvent: CfLogQuestionEvent!

    override func setUp() {
        super.setUp()
        logQuestionEvent = CfLogQuestionEvent()
    }

    override func tearDown() {
        logQuestionEvent = nil
        super.tearDown()
    }

    func testSetQuestionId() {
        logQuestionEvent.setQuestionId("123")
        XCTAssertEqual(logQuestionEvent.questionId, "123")
    }

    func testSetExamId() {
        logQuestionEvent.setExamId("456")
        XCTAssertEqual(logQuestionEvent.examId, "456")
    }

    func testSetQuestionActionWithEnum() {
        logQuestionEvent.setQuestionAction(.answer)
        XCTAssertEqual(logQuestionEvent.action, QuestionAction.answer.rawValue)
    }

    func testSetQuestionActionWithString() {
        logQuestionEvent.setQuestionAction("answer")
        XCTAssertEqual(logQuestionEvent.action, "answer")
    }

    func testSetAnswerId() {
        logQuestionEvent.setAnswerId("789")
        XCTAssertEqual(logQuestionEvent.answerId, "789")
    }

    func testSetMeta() {
        logQuestionEvent.setMeta("Additional information")
        XCTAssertEqual(logQuestionEvent.meta as? String, "Additional information")
    }

    func testUpdateImmediately() {
        logQuestionEvent.updateImmediately(true)
        XCTAssertEqual(logQuestionEvent.updateImmediately, true)
    }

    func testBuildWithValidInputs() {
        logQuestionEvent.setQuestionId("123")
            .setExamId("456")
            .setQuestionAction("answer")
            .setAnswerId("789")
            .setMeta("Additional information")
            .updateImmediately(true)
            .build()

        // Add assertions based on your requirements
    }

    func testBuildWithMissingRequiredFields() {
        // Missing questionId
        logQuestionEvent
            .setExamId("456")
            .setQuestionAction("answer")
            .setAnswerId("789")
            .setMeta("Additional information")
            .updateImmediately(true)

        // Add assertions to check for an exception or handle accordingly
    }
}
