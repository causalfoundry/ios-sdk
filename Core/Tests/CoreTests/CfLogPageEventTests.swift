//
//  CfLogPageEventTests.swift
//  
//
//  Created by khushbu on 19/10/23.
//

import XCTest
@testable import CasualFoundryCore 

class CfLogPageBuilderTests: XCTestCase {
    
    var builder: CfLogPageBuilder!
    
    override func setUp() {
        super.setUp()
        // Create an instance of CfLogPageBuilder before each test
        builder = CfLogPageBuilder()
    }
    
    override func tearDown() {
        // Clean up after each test
        builder = nil
        super.tearDown()
    }
    
    func testSetPath() {
        // Test setting the path
        _ = builder.setPath(path: "TestPath")
        XCTAssertEqual(builder.path_value, "TestPath")
    }
    
    func testSetTitle() {
        // Test setting the title
       _ =  builder.setTitle(title: "TestTitle")
        XCTAssertEqual(builder.title_value, "TestTitle")
    }
    
    func testSetDuration() {
        // Test setting the duration
       _ = builder.setDuration(duration: 10.5)
        XCTAssertEqual(builder.duration_value, 10.5)
    }
    
    func testSetRenderTime() {
        // Test setting the render time
        _ = builder.setRenderTime(render_time: 500)
        XCTAssertEqual(builder.render_time_value, 500)
    }
    
    func testSetContentBlock() {
        // Test setting the content block
        _ = builder.setContentBlock(content_block: .core)
        XCTAssertEqual(builder.content_block, ContentBlock.core.rawValue)
    }
    
    func testSetMeta() {
        // Test setting the meta
        _ = builder.setMeta(meta: ["key": "value"])
        XCTAssertEqual(builder.meta as? [String: String], ["key": "value"])
    }
    
    func testUpdateImmediately() {
        // Test setting updateImmediately
       _ =  builder.updateImmediately(update_immediately: true)
        XCTAssertTrue(builder.update_immediately)
    }
    
    func testBuild() {
        // Test the build method
        _ = builder.setPath(path: "TestPath")
        _ = builder.setTitle(title: "TestTitle")
        _ = builder.setDuration(duration: 10.5)
        _ = builder.setRenderTime(render_time: 500)
        _ = builder.setContentBlock(content_block: .core)
        _ = builder.setMeta(meta: ["key": "value"])
        _ = builder.updateImmediately(update_immediately: false)
        
        // You can add assertions to verify the behavior of the build method
        // For example, you can check if it calls CFSetup().track correctly.
        
        builder.build()
        
        // Add your assertions here
    }
}
