//
//  EventDataObject.swift
//  
//
//  Created by khushbu on 21/09/23.
//

import Foundation

struct EventDataObject: Codable {
    
    enum CodingKeys: String, CodingKey {
        case block
        case ol
        case ts
        case type
        case props
    }
    
    let block: String
    let ol: Bool
    let ts: String
    let type: String
    let props: [String: Any]?
    
    init<T: Codable>(block: String, ol: Bool, ts: Date, type: String, props: T) {
        self.block = block
        self.ol = ol
        self.ts = ISO8601DateFormatter().string(from: ts)
        self.type = type
        self.props = props.dictionary
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.block = try container.decode(String.self, forKey: .block)
        self.ol = try container.decode(Bool.self, forKey: .ol)
        self.ts = try container.decode(String.self, forKey: .ts)
        self.type = try container.decode(String.self, forKey: .type)
        self.props = try container.decodeIfPresent([String: Any].self, forKey: .props)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(block, forKey: .block)
        try container.encode(ol, forKey: .ol)
        try container.encode(ts, forKey: .ts)
        try container.encode(type, forKey: .type)
        try container.encodeIfPresent(props, forKey: .props)
    }
}
