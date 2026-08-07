import XCTest

@testable import KenkaiSDKCore

final class CfOtherCatalogTests: XCTestCase {
    private var wasPaused = false
    private var wasDebugMode = false
    private var wasAppDebuggable = false

    override func setUp() {
        super.setUp()
        wasPaused = CoreConstants.shared.pauseSDK
        wasDebugMode = CoreConstants.shared.isDebugMode
        wasAppDebuggable = CoreConstants.shared.isAppDebuggable
        CoreConstants.shared.pauseSDK = false
        CoreConstants.shared.isDebugMode = false
        CoreConstants.shared.isAppDebuggable = false
        MMKVHelper.shared.deleteCatalogData()
    }

    override func tearDown() {
        MMKVHelper.shared.deleteCatalogData()
        MMKVHelper.shared.deleteDataEventLogs()
        CoreConstants.shared.pauseSDK = wasPaused
        CoreConstants.shared.isDebugMode = wasDebugMode
        CoreConstants.shared.isAppDebuggable = wasAppDebuggable
        super.tearDown()
    }

    func testCustomCatalogMatchesWebContract() throws {
        let catalog = OtherCatalogModel(
            name: "Household Details",
            meta: [
                "Head Household ID": "SomeId",
                "headHouseholdId": "lowercase-only",
                "details": ["School Status": "not_available"],
                "population": Int64(3_000_000_000),
                "member_ages": [Int64(1), Int64(2)],
                "is_approved": true
            ]
        )

        CFCoreEvent.shared.logCatalog(
            coreCatalogType: .Other,
            subjectId: "SomeHouseholdId",
            catalogModel: catalog
        )
        let item = try XCTUnwrap(MMKVHelper.shared.readCatalogData().last)

        XCTAssertEqual("Head Household ID".toSnakeCase(), "head_household_id")
        XCTAssertEqual("head_household_id".toSnakeCase(), "head_household_id")
        XCTAssertEqual("headHouseholdId".toSnakeCase(), "headhouseholdid")
        XCTAssertEqual("\u{FEFF}Household\u{00A0}\t Details\u{FEFF}".toSnakeCase(), "household_details")
        XCTAssertEqual(CoreCatalogType.Other.rawValue, "other")
        XCTAssertEqual(item.type, "household_details")
        XCTAssertEqual(item.keyValues, [
            "name": "Household Details",
            "head_household_id": "SomeId",
            "headhouseholdid": "lowercase-only",
            "school_status": "not_available",
            "population": "3000000000",
            "member_ages": "1, 2",
            "is_approved": "true"
        ])

        MMKVHelper.shared.deleteCatalogData()
        CFCoreEvent.shared.logCatalog(
            coreCatalogType: .Other,
            subjectId: "SomeSiteId",
            catalogModel: OtherCatalogModel(name: "site", meta: ["name": "reserved"])
        )
        XCTAssertTrue(MMKVHelper.shared.readCatalogData().isEmpty)

        let emptyMetaData = try JSONEncoder().encode(OtherCatalogModel(name: "empty", meta: [:]))
        XCTAssertTrue(try JSONDecoder().decode(OtherCatalogModel.self, from: emptyMetaData).meta.isEmpty)
    }
}
