//
//  MilestoneObject.swift
//
//
//  Created by khushbu on 07/11/23.
//

import Foundation


public struct MilestoneObject: Codable {
    let id: String
    let action: String
    let meta: Any?
    
    // Custom initializer
    public init(id: String, action: String, meta: Any? = nil) {
        self.id = id
        self.action = action
        self.meta = meta
    }
    
    // CodingKeys for encoding and decoding
    private enum CodingKeys: String, CodingKey {
        case id
        case action
        case meta
    }
    
    // Encode the object to JSON
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(action, forKey: .action)
        if let meta = meta {
            try container.encode(meta, forKey: .meta)
        }
    }
    
    // Decode the object from JSON
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        action = try container.decode(String.self, forKey: .action)
        meta = try? container.decode(Any.self, forKey: .meta)
    }
}
