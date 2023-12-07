//
//  CancelCheckoutObject.swift
//
//
//  Created by khushbu on 01/11/23.
//

import Foundation

struct CancelCheckoutObject: Codable {
    var id: String
    var type: String
    var items: [ItemTypeModel] = []
    var reason: String = ""
    var meta: Encodable? = nil

    public init(id: String, type: String, items: [ItemTypeModel], reason: String = "", meta: Encodable? = nil) {
        self.id = id
        self.type = type
        self.items = items
        self.reason = reason
        self.meta = meta
    }

    // CodingKeys to map the keys if they differ from the property names
    enum CodingKeys: String, CodingKey {
        case id
        case type
        case items
        case reason
        case meta
    }

    // Custom encoding method
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(type, forKey: .type)
        try container.encode(reason, forKey: .reason)
        try container.encode(items, forKey: .items)
        if let metaData = meta {
            try container.encode(metaData, forKey: .meta)
        }
        
    }

    // Custom decoding method
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        type = try container.decode(String.self, forKey: .type)
        reason = try container.decode(String.self, forKey: .reason)
        items = try container.decode([ItemTypeModel].self, forKey: .items)
        if let metaData = try? container.decodeIfPresent(Data.self, forKey: .meta) {
            meta = try? (JSONSerialization.jsonObject(with: metaData, options: .allowFragments) as! any Encodable)
        } else {
            meta = nil
        }
    }
    
}
