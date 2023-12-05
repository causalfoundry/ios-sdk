//
//  EventDataObject.swift
//  
//
//  Created by khushbu on 21/09/23.
//

import Foundation

struct EventDataObject: Codable {
    
    enum CodingKeys: String, CodingKey {
        case content_block = "block"
        case online = "ol"
        case ts
        case event_type = "type"
        case event_properties = "props"
    }
    
    let content_block: String
    let online: Bool
    let ts: String
    let event_type: String
    let event_properties: Data?
}
