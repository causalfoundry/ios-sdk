//
//  CfLogMediaEventTests.swift
//
//
//  Created by khushbu on 24/10/23.
//

import XCTest
@testable import CasualFoundryCore

class CfLogMediaEventTests: XCTestCase {
    
    var cfLogMediaEvent: CfLogMediaEvent!
    
    override func setUp() {
        super.setUp()
        
        let media_id = "123"
        let media_type = "video"
        let media_action = "play"
        let duration_value = 60
        let content_block = "core"
        let mediaModel_value = MediaCatalogModel()
        let meta: Any? = "Testing Meta Data"
        let update_immediately = true

        cfLogMediaEvent = CfLogMediaEvent(media_id: media_id, media_type: media_type, media_action: media_action, duration_value: duration_value, content_block: content_block, mediaModel_value: mediaModel_value, meta: meta, update_immediately: update_immediately)
    }
    
    override func tearDown() {
        cfLogMediaEvent = nil
        super.tearDown()
    }
    
    func testInit() {
        XCTAssertNotNil(cfLogMediaEvent.media_id)
        XCTAssertNotNil(cfLogMediaEvent.media_type)
        XCTAssertNotNil(cfLogMediaEvent.media_action)
        XCTAssertNotNil(cfLogMediaEvent.duration_value)
        XCTAssertNotNil(cfLogMediaEvent.content_block, CoreConstants.shared.contentBlockName)
        XCTAssertNotNil(cfLogMediaEvent.mediaModel_value)
        XCTAssertNotNil(cfLogMediaEvent.meta)
      
    }
    
    func testSetMediaTypeWithEnum() {
        let mediaType: MediaType = .audio
        let builder = CfLogMediaEventBuilder()
        
        builder.setMediaType(media_type: mediaType)
        
        XCTAssertEqual(builder.media_type, mediaType.rawValue)
    }
    
    func testSetMediaTypeWithString() {
        let mediaTypeString = "audio"
        let builder = CfLogMediaEventBuilder()
        
        builder.setMediaType(media_type: mediaTypeString)
        
        XCTAssertEqual(builder.media_type, mediaTypeString)
    }
    
    func testSetContentBlockWithEnum() {
        let contentBlock: ContentBlock = .core
        let builder = CfLogMediaEventBuilder()
        
        builder.setContentBlock(content_block: contentBlock)
        
        XCTAssertEqual(builder.content_block, contentBlock.rawValue)
    }
    
    func testSetContentBlockWithString() {
        let contentBlockString = "core"
        let builder = CfLogMediaEventBuilder()
        
        builder.setContentBlock(content_block: contentBlockString)
        
        XCTAssertEqual(builder.content_block, contentBlockString)
    }
    
    func testSetMeta() {
        let meta = "additional information"
        let builder = CfLogMediaEventBuilder()
        
        builder.setMeta(meta: meta)
        
        XCTAssertEqual(builder.meta as? String, meta)
    }
    
    func testUpdateImmediately() {
        let updateImmediately = true
        let builder = CfLogMediaEventBuilder()
        
        builder.updateImmediately(update_immediately: updateImmediately)
        
        XCTAssertEqual(builder.update_immediately, updateImmediately)
    }
}

