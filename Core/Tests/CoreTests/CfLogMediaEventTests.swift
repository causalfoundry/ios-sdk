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
        XCTAssertNil(cfLogMediaEvent.media_id)
        XCTAssertNil(cfLogMediaEvent.media_type)
        XCTAssertNil(cfLogMediaEvent.media_action)
        XCTAssertNil(cfLogMediaEvent.duration_value)
        XCTAssertEqual(cfLogMediaEvent.content_block, CoreConstants.shared.contentBlockName)
        XCTAssertNil(cfLogMediaEvent.mediaModel_value)
        XCTAssertNil(cfLogMediaEvent.meta)
        XCTAssertEqual(cfLogMediaEvent.update_immediately, CoreConstants.shared.updateImmediately)
    }
    
    func testSetMediaTypeWithEnum() {
        let mediaType: MediaType = .audio
        let builder = CfLogMediaEventBuilder()
        
        builder.setMediaType(media_type: mediaType).build()
        
        XCTAssertEqual(builder.media_type, mediaType.rawValue)
    }
    
    func testSetMediaTypeWithString() {
        let mediaTypeString = "audio"
        let builder = CfLogMediaEventBuilder()
        
        builder.setMediaType(media_type: mediaTypeString).build()
        
        XCTAssertEqual(builder.media_type, mediaTypeString)
    }
    
    func testSetContentBlockWithEnum() {
        let contentBlock: ContentBlock = .core
        let builder = CfLogMediaEventBuilder()
        
        builder.setContentBlock(content_block: contentBlock).build()
        
        XCTAssertEqual(builder.content_block, contentBlock.rawValue)
    }
    
    func testSetContentBlockWithString() {
        let contentBlockString = "core"
        let builder = CfLogMediaEventBuilder()
        
        builder.setContentBlock(content_block: contentBlockString).build()
        
        XCTAssertEqual(builder.content_block, contentBlockString)
    }
    
    func testSetMeta() {
        let meta = "additional information"
        let builder = CfLogMediaEventBuilder()
        
        builder.setMeta(meta: meta).build()
        
        XCTAssertEqual(builder.meta as? String, meta)
    }
    
    func testUpdateImmediately() {
        let updateImmediately = true
        let builder = CfLogMediaEventBuilder()
        
        builder.updateImmediately(update_immediately: updateImmediately).build()
        
        XCTAssertEqual(builder.update_immediately, updateImmediately)
    }
}

