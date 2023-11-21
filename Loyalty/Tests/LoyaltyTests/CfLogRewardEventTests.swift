import XCTest

class CfLogRewardEventTests: XCTestCase {

    func testSetRewardId() {
        let cfLogRewardEvent = CfLogRewardEvent()
        let result = cfLogRewardEvent.setRewardId("reward123")
        XCTAssertEqual(result.reward_id, "reward123")
    }

    func testSetActionWithEnum() {
        let cfLogRewardEvent = CfLogRewardEvent()
        let result = cfLogRewardEvent.setAction(action: RewardAction.view)
        XCTAssertEqual(result.action_value, "view")
    }

    func testSetActionWithStringValidValue() {
        let cfLogRewardEvent = CfLogRewardEvent()
        let result = cfLogRewardEvent.setAction(action: "view")
        XCTAssertEqual(result.action_value, "view")
    }

    func testSetActionWithStringInvalidValue() {
        let cfLogRewardEvent = CfLogRewardEvent()
        XCTAssertThrowsError(try cfLogRewardEvent.setAction(action: "invalidAction"))
    }

    func testSetAccumulatedPoints() {
        let cfLogRewardEvent = CfLogRewardEvent()
        let result = cfLogRewardEvent.setAccumulatedPoints(50.0)
        XCTAssertEqual(result.acc_points, 50.0)
    }

    func testSetTotalPoints() {
        let cfLogRewardEvent = CfLogRewardEvent()
        let result = cfLogRewardEvent.setTotalPoints(100.0)
        XCTAssertEqual(result.total_points, 100.0)
    }

    func testSetRedeemObjectWithObject() {
        let cfLogRewardEvent = CfLogRewardEvent()
        let redeemObject = RedeemObject(type: "cash", points_withdrawn: 10, converted_value: 5.0, is_successful: true, currency: "USD")
        let result = cfLogRewardEvent.setRedeemObject(redeem_object: redeemObject)
        XCTAssertEqual(result.redeem_object, redeemObject)
    }

    func testSetRedeemObjectWithStringValidValue() {
        let cfLogRewardEvent = CfLogRewardEvent()
        let redeemObjectString = """
        {
            "type": "cash",
            "points_withdrawn": 10,
            "converted_value": 5.0,
            "is_successful": true,
            "currency": "USD"
        }
        """
        let result = cfLogRewardEvent.setRedeemObject(redeem_object: redeemObjectString)
        XCTAssertNotNil(result.redeem_object)
    }

    func testSetRedeemObjectWithStringInvalidValue() {
        let cfLogRewardEvent = CfLogRewardEvent()
        let redeemObjectString = """
        {
            "type": "invalidType",
            "points_withdrawn": 10,
            "converted_value": 5.0,
            "is_successful": true,
            "currency": "USD"
        }
        """
        XCTAssertThrowsError(try cfLogRewardEvent.setRedeemObject(redeem_object: redeemObjectString))
    }

    func testSetMeta() {
        let cfLogRewardEvent = CfLogRewardEvent()
        let result = cfLogRewardEvent.setMeta(meta: "Additional information")
        XCTAssertEqual(result.meta as? String, "Additional information")
    }

    func testUpdateImmediately() {
        let cfLogRewardEvent = CfLogRewardEvent()
        let result = cfLogRewardEvent.updateImmediately(update_immediately: true)
        XCTAssertTrue(result.update_immediately)
    }

    func testBuildWithValidData() {
        let cfLogRewardEvent = CfLogRewardEvent()
        cfLogRewardEvent.setRewardId("reward123")
        cfLogRewardEvent.setAction(action: "view")
        cfLogRewardEvent.setTotalPoints(100.0)
        cfLogRewardEvent.build()
    }

    func testBuildWithoutRewardId() {
        let cfLogRewardEvent = CfLogRewardEvent()
        cfLogRewardEvent.setAction(action: "view")
        cfLogRewardEvent.setTotalPoints(100.0)
        cfLogRewardEvent.build()
    }

    func testBuildWithoutAction() {
        let cfLogRewardEvent = CfLogRewardEvent()
        cfLogRewardEvent.setRewardId("reward123")
        cfLogRewardEvent.setTotalPoints(100.0)
        cfLogRewardEvent.build()
    }

    func testBuildWithoutTotalPoints() {
        let cfLogRewardEvent = CfLogRewardEvent()
        cfLogRewardEvent.setRewardId("reward123")
        cfLogRewardEvent.setAction(action: "view")
        cfLogRewardEvent.build()
    }

    func testBuildWithInvalidRedeemObject() {
        let cfLogRewardEvent = CfLogRewardEvent()
        cfLogRewardEvent.setRewardId("reward123")
        cfLogRewardEvent.setAction(action: "redeem")
        cfLogRewardEvent.setTotalPoints(100.0)
        cfLogRewardEvent.build()
    }

    func testCallEventTrack() {
        let cfLogRewardEvent = CfLogRewardEvent()
        let rewardEventObject = RewardEventObject(
            rewardId: "reward123",
            action: "view",
            accPoints: 50.0,
            totalPoints: 100.0,
            redeem: nil,
            usdRate: 1.0,
            meta: nil
        )
        cfLogRewardEvent.callEventTrack(rewardEventObject)
    }
}

