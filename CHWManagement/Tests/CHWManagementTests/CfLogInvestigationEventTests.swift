//
//  CfLogInvestigationEventTests.swift
//
//
//  Created by khushbu on 26/10/23.
//

import XCTest

@testable import CasualFoundryCHWManagement
@testable import CausalFoundrySDKCore

class CfLogInvestigationEventTests: XCTestCase {
    var logEvent: CfLogInvestigationEvent!

    override func setUp() {
        super.setUp()
        logEvent = CfLogInvestigationEvent()
    }

    override func tearDown() {
        logEvent = nil
        super.tearDown()
    }

    func testSetPatientId() {
        logEvent.setPatientId("12345")
        XCTAssertEqual(logEvent.patientId, "12345")
    }

    func testSetSiteId() {
        logEvent.setSiteId("SiteA")
        XCTAssertEqual(logEvent.siteId, "SiteA")
    }

    func testSetInvestigationId() {
        logEvent.setInvestigationId("Investigation123")
        XCTAssertEqual(logEvent.investigationId, "Investigation123")
    }

    func testAddInvestigationItem() {
        let item = InvestigationItem(name: "Test1", testValue: "Mg", testUnit: "testsd", orderedDate: 12_232_323, testedDate: 343_434_343, action: "add", remarks: "Test")
        logEvent.addInvestigationItem(item)
        XCTAssertEqual(logEvent.prescribedTestsList.count, 1)
        XCTAssertEqual(logEvent.prescribedTestsList.first, item)
    }

    func testSetInvestigationList() {
        let item1 = InvestigationItem(name: "Test1", testValue: "Mg", testUnit: "testsd", orderedDate: 12_232_323, testedDate: 343_434_343, action: "add", remarks: "Test")
        let item2 = InvestigationItem(name: "Test2", testValue: "Mg", testUnit: "testsd", orderedDate: 12_232_323, testedDate: 343_434_343, action: "add", remarks: "Test")
        let itemList = [item1, item2]
        logEvent.setInvestigationList(itemList)
        XCTAssertEqual(logEvent.prescribedTestsList, itemList)
    }

    func testSetMeta() {
        let meta = "Testas"
        logEvent.setMeta(meta)
        XCTAssertEqual(logEvent.meta as! String, meta)
    }

    func testUpdateImmediately() {
        logEvent.updateImmediately(true)
        XCTAssertTrue(logEvent.updateImmediately)
    }

    func testBuildWithMissingData() {
        // Simulate a case where required data is missing
        logEvent.setPatientId("12345")
        // Other required data is not set

        // You should write XCTest assertions to validate that ExceptionManager is called
        // to handle missing data and exceptions are thrown.
        // Use XCTest assertions to validate this behavior.
    }

    func testBuildWithValidData() {
        // Set all the required data for a valid log event
        logEvent.setPatientId("12345")
        logEvent.setSiteId("SiteA")
        logEvent.setInvestigationId("Investigation123")
        let item = InvestigationItem(name: "Test1", testValue: "Mg", testUnit: "testsd", orderedDate: 12_232_323, testedDate: 343_434_343, action: "add", remarks: "Test")
        logEvent.addInvestigationItem(item)

        XCTAssertNoThrow(logEvent.build())
    }
}
