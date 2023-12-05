//
//  ItemRequestObject.swift
//
//
//  Created by khushbu on 01/11/23.
//

import Foundation

public struct ItemRequestObject: Codable {
    let item_request_id: String
    let item_name: String
    let manufacturer: String
    let meta: Encodable?

    enum CodingKeys: String, CodingKey {
        case item_request_id = "id"
        case item_name
        case manufacturer
        case meta
    }

    public init(
        item_request_id: String,
        item_name: String,
        manufacturer: String,
        meta: Encodable? = nil
    ) {
        self.item_request_id = item_request_id
        self.item_name = item_name
        self.manufacturer = manufacturer
        self.meta = meta
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        item_request_id = try container.decode(String.self, forKey: .item_request_id)
        item_name = try container.decode(String.self, forKey: .item_name)
        manufacturer = try container.decode(String.self, forKey: .manufacturer)
        if let metaData = try container.decodeIfPresent(Data.self, forKey: .meta) {
            meta = try? (JSONSerialization.jsonObject(with: metaData, options: .allowFragments) as! any Encodable)
        } else {
            meta = nil
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(item_request_id, forKey: .item_request_id)
        try container.encode(item_name, forKey: .item_name)
        try container.encode(manufacturer, forKey: .manufacturer)
        if let metaData = meta {
            try container.encode(metaData, forKey: .meta)
        }
    }
}
