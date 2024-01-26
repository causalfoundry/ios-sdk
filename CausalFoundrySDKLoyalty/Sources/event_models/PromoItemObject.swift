//
//  PromoItemObject.swift
//
//
//  Created by khushbu on 07/11/23.
//

import Foundation

public struct PromoItemObject: Codable {
    let item_id: String
    let item_type: String

    enum CodingKeys: String, CodingKey {
        case item_id = "id"
        case item_type = "type"
    }

    public init(item_id: String, item_type: String) {
        self.item_id = item_id
        self.item_type = item_type
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(item_id, forKey: .item_id)
        try container.encode(item_type, forKey: .item_type)
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        item_id = try container.decode(String.self, forKey: .item_id)
        item_type = try container.decode(String.self, forKey: .item_type)
    }
}
