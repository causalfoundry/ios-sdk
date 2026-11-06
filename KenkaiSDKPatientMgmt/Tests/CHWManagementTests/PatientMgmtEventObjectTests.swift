import XCTest

@testable import KenkaiSDKPatientMgmt

final class PatientMgmtEventObjectTests: XCTestCase {
    func testPatientEventObjectEncodesItsIdentifiers() throws {
        let object = PatientEventObject(
            patientId: "p1", siteId: "s1", action: HcwItemAction.Add, isFromGho: false,
            location: "L", type: PatientType.Outpatient, subType: "x")
        let json = try XCTUnwrap(String(data: JSONEncoder().encode(object), encoding: .utf8))
        XCTAssertTrue(json.contains("\"p1\""), json)
        XCTAssertTrue(json.contains("\"s1\""), json)
    }
}
