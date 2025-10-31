import XCTest

class CfLogMilestoneEventTests: XCTestCase {
    func testSetMilestoneId() {
        let cfLogMilestoneEvent = CfLogMilestoneEvent()
        let result = cfLogMilestoneEvent.setMilestoneId("123")
        XCTAssertEqual(result.milestone_id, "123")
    }

    func testSetActionWithEnum() {
        let cfLogMilestoneEvent = CfLogMilestoneEvent()
        let result = cfLogMilestoneEvent.setAction(MilestoneAction.achieved)
        XCTAssertEqual(result.action_value, "achieved")
    }

    func testSetActionWithStringValidValue() {
        let cfLogMilestoneEvent = CfLogMilestoneEvent()
        let result = cfLogMilestoneEvent.setAction("achieved")
        XCTAssertEqual(result.action_value, "achieved")
    }

    func testSetActionWithStringInvalidValue() {
        let cfLogMilestoneEvent = CfLogMilestoneEvent()
        XCTAssertThrowsError(try cfLogMilestoneEvent.setAction("invalidAction"))
    }

    func testSetMeta() {
        let cfLogMilestoneEvent = CfLogMilestoneEvent()
        let result = cfLogMilestoneEvent.setMeta("Additional information")
        XCTAssertEqual(result.meta as? String, "Additional information")
    }

    func testUpdateImmediately() {
        let cfLogMilestoneEvent = CfLogMilestoneEvent()
        let result = cfLogMilestoneEvent.updateImmediately(true)
        XCTAssertTrue(result.update_immediately)
    }

    func testBuildWithValidData() {
        let cfLogMilestoneEvent = CfLogMilestoneEvent()
        cfLogMilestoneEvent.setMilestoneId("123")
        cfLogMilestoneEvent.setAction("achieved")
        cfLogMilestoneEvent.setMeta("Additional information")
        cfLogMilestoneEvent.updateImmediately(true)
        cfLogMilestoneEvent.build()
    }

    func testBuildWithoutMilestoneId() {
        let cfLogMilestoneEvent = CfLogMilestoneEvent()
        cfLogMilestoneEvent.setAction("achieved")
        cfLogMilestoneEvent.setMeta("Additional information")
        cfLogMilestoneEvent.updateImmediately(true)
        cfLogMilestoneEvent.build()
    }

    func testBuildWithoutAction() {
        let cfLogMilestoneEvent = CfLogMilestoneEvent()
        cfLogMilestoneEvent.setMilestoneId("123")
        cfLogMilestoneEvent.setMeta("Additional information")
        cfLogMilestoneEvent.updateImmediately(true)
        cfLogMilestoneEvent.build()
    }

    // Add more test cases as needed
}
