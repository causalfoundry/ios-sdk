//
//  PromoItemObject.swift
//
//
//  Created by khushbu on 07/11/23.
//

import Foundation

public struct PromoItemObject: Codable {
    let itemId: String
    let itemType: String

    private enum CodingKeys: String, CodingKey {
        case itemId = "id"
        case itemType = "type"
    }

    public init(itemId: String, itemType: PromoItemType) {
        self.itemId = itemId
        self.itemType = itemType.rawValue
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(itemId, forKey: .itemId)
        try container.encode(itemType, forKey: .itemType)
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        itemId = try container.decode(String.self, forKey: .itemId)
        itemType = try container.decode(String.self, forKey: .itemType)
    }
}
