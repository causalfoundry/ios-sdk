//
//  ItemRequestObject.swift
//
//
//  Created by khushbu on 01/11/23.
//

import Foundation

public struct ItemRequestObject: Codable {
    let itemRequestId: String
    let itemName: String
    let manufacturer: String
    let meta: Encodable?

    private enum CodingKeys: String, CodingKey {
        case itemRequestId = "id"
        case itemName = "item_name"
        case manufacturer
        case meta
    }

    public init(itemRequestId: String, itemName: String, manufacturer: String, meta: Encodable? = nil) {
        self.itemRequestId = itemRequestId
        self.itemName = itemName
        self.manufacturer = manufacturer
        self.meta = meta
    }

    // Custom encoding method
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(itemRequestId, forKey: .itemRequestId)
        try container.encode(itemName, forKey: .itemName)
        try container.encode(manufacturer, forKey: .manufacturer)
        if let metaData = meta {
            try container.encode(metaData, forKey: .meta)
        }
    }

    // Custom decoding method
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        itemRequestId = try container.decode(String.self, forKey: .itemRequestId)
        itemName = try container.decode(String.self, forKey: .itemName)
        manufacturer = try container.decode(String.self, forKey: .manufacturer)
        if let metaData = try? container.decodeIfPresent(Data.self, forKey: .meta) {
            meta = try? (JSONSerialization.jsonObject(with: metaData, options: .allowFragments) as! any Encodable)
        } else {
            meta = nil
        }
    }
}
