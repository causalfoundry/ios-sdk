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
    let meta: Encodable?

    // Custom initializer
    public init(id: String, action: MilestoneAction, meta: Encodable? = nil) {
        self.id = id
        self.action = action.rawValue
        self.meta = meta
    }

    // CodingKeys for encoding and decoding
    private enum CodingKeys: String, CodingKey {
        case id = "milestone_id"
        case action
        case meta
    }
    // Encode the object to JSON
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(action, forKey: .action)
        if let metaData = meta {
            try container.encode(metaData, forKey: .meta)
        }
    }

    // Decode the object from JSON
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        action = try container.decode(String.self, forKey: .action)
        if let metaData = try? container.decodeIfPresent(Data.self, forKey: .meta) {
            meta = try? (JSONSerialization.jsonObject(with: metaData, options: .allowFragments) as! any Encodable)
        } else {
            meta = nil
        }
    }
}
