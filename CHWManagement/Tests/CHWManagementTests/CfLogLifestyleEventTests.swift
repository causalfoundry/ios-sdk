//
//  CfLogLifestyleEventTests.swift
//
//
//  Created by khushbu on 26/10/23.
//

import XCTest

@testable import CasualFoundryCHWManagement
@testable import CasualFoundryCore

class CfLogLifestyleEventTests: XCTestCase {
    var cfLogLifestyleEvent: CfLogLifestyleEvent!

    override func setUp() {
        super.setUp()
        cfLogLifestyleEvent = CfLogLifestyleEvent()
    }

    override func tearDown() {
        cfLogLifestyleEvent = nil
        super.tearDown()
    }

    func testSetPatientId() {
        cfLogLifestyleEvent.setPatientId("123")
        XCTAssertEqual(cfLogLifestyleEvent.patientId, "123")
    }

    func testSetSiteId() {
        cfLogLifestyleEvent.setSiteId("Site123")
        XCTAssertEqual(cfLogLifestyleEvent.siteId, "Site123")
    }

    func testSetLifestyleId() {
        cfLogLifestyleEvent.setLifestyleId("Lifestyle123")
        XCTAssertEqual(cfLogLifestyleEvent.lifestyleId, "Lifestyle123")
    }

    func testAddLifestylePlanItem() {
        let lifestylePlanItem = LifestylePlanItem(name: "Exercise", action: "Action")
        cfLogLifestyleEvent.addLifestylePlanItem(lifestylePlanItem)
        XCTAssertTrue(cfLogLifestyleEvent.lifestylePlanList.contains(where: { _ in
            true
        }))
    }

    func testAddLifestylePlanItemFromString() {
        let lifestylePlanItemString = """
        {
            "name": "Exercise",
            "action": "Action"
        }
        """
        cfLogLifestyleEvent.addLifestylePlanItem(lifestylePlanItemString)
        XCTAssertEqual(cfLogLifestyleEvent.lifestylePlanList.count, 1)
    }

    func testSetLifestylePlanList() {
        let lifestylePlanList = [LifestylePlanItem(name: "Exercise", action: "Action")]
        cfLogLifestyleEvent.setLifestylePlanList(lifestylePlanList)
        XCTAssertEqual(cfLogLifestyleEvent.lifestylePlanList, lifestylePlanList)
    }

    func testSetLifestylePlanListFromString() {
        let lifestylePlanListString = """
        [
            {
                "name": "Exercise",
                "action": "Action"
            }
        ]
        """
        cfLogLifestyleEvent.setLifestylePlanList(lifestylePlanListString)
        XCTAssertEqual(cfLogLifestyleEvent.lifestylePlanList.count, 1)
    }

    func testSetMeta() {
        let meta = "Additional info"
        cfLogLifestyleEvent.setMeta(meta)
        XCTAssertEqual(cfLogLifestyleEvent.meta as? String, meta)
    }

    func testUpdateImmediately() {
        cfLogLifestyleEvent.updateImmediately(true)
        XCTAssertTrue(cfLogLifestyleEvent.updateImmediately)
    }

    func testBuildWithValidData() {
        cfLogLifestyleEvent
            .setPatientId("123")
            .setSiteId("Site123")
            .setLifestyleId("Lifestyle123")
            .addLifestylePlanItem(LifestylePlanItem(name: "Exercise", action: "Action"))
            .setMeta("Additional info")
            .updateImmediately(true)

        XCTAssertNoThrow(cfLogLifestyleEvent.build())
    }
}
