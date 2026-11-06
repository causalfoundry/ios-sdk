import XCTest

@testable import KenkaiSDKLoyalty

final class LoyaltyEventObjectTests: XCTestCase {
    func testMilestoneObjectEncodesItsIdentifier() throws {
        let object = MilestoneObject(id: "m1", action: .Achieved)
        let json = try XCTUnwrap(String(data: JSONEncoder().encode(object), encoding: .utf8))
        XCTAssertTrue(json.contains("\"m1\""), json)
    }
}
