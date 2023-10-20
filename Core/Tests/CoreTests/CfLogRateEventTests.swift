//
//  CfLogRateEventTests.swift
//  
//
//  Created by khushbu on 19/10/23.
//

import XCTest
@testable import CasualFoundryCore

class CfLogRateEventBuilderTests: XCTestCase {
    
    var builder: CfLogRateEventBuilder!
    
    override func setUp() {
        super.setUp()
        // Create an instance of CfLogRateEventBuilder before each test
        builder = CfLogRateEventBuilder()
    }
    
    override func tearDown() {
        // Clean up after each test
        builder = nil
        super.tearDown()
    }
    
    func testSetContentBlockWithEnum() {
        // Test setting the content block with enum
        builder.setContentBlock(contentBlock: .core)
        XCTAssertEqual(builder.contentBlock, ContentBlock.core.rawValue)
    }
    
    func testSetContentBlockWithString() {
        // Test setting the content block with a valid string
        builder.setContentBlock(contentBlock: "core")
        XCTAssertEqual(builder.contentBlock, "core")
    }
    
    func testSetContentBlockWithInvalidString() {
        // Test setting the content block with an invalid string
        // This should throw an exception
        XCTAssertThrowsError(try builder.setContentBlock(contentBlock: "invalid_block"))
    }
    
    func testSetRateValue() {
        // Test setting the rate value
        builder.setRateValue(rateValue: 4.5)
        XCTAssertEqual(builder.rateValue, 4.5)
    }
    
    func testSetRateTypeWithEnum() {
        // Test setting the rate type with enum
        builder.setRateType(type: .app)
        XCTAssertEqual(builder.type, RateType.app.rawValue)
    }
    
    func testSetRateTypeWithString() {
        // Test setting the rate type with a valid string
        builder.setRateType(type: "app")
        XCTAssertEqual(builder.type, "app")
    }
    
    func testSetRateTypeWithInvalidString() {
        // Test setting the rate type with an invalid string
        // This should throw an exception
        XCTAssertThrowsError(try builder.setRateType(type: "invalid_type"))
    }
    
    func testSetSubjectId() {
        // Test setting the subjectId
        builder.setSubjectId(subjectId: "12345")
        XCTAssertEqual(builder.subjectId, "12345")
    }
    
    func testSetMeta() {
        // Test setting the meta
        builder.setMeta(meta: ["key": "value"])
        XCTAssertEqual(builder.meta as? [String: String], ["key": "value"])
    }
    
    func testUpdateImmediately() {
        // Test setting updateImmediately
        builder.updateImmediately(updateImmediately: true)
        XCTAssertTrue(builder.updateImmediately)
    }
    
    func testBuild() {
        // Test the build method
        
        // Set required properties
        builder.setContentBlock(contentBlock: .core)
        builder.setRateValue(rateValue: 4.0)
        builder.setRateType(type: .app)
        builder.setSubjectId(subjectId: "12345")
        builder.updateImmediately(updateImmediately: false)
        
        // You can add assertions to verify the behavior of the build method
        // For example, you can check if it calls CFSetup().track correctly.
        
        builder.build()
        
        // Add your assertions here
    }
}
