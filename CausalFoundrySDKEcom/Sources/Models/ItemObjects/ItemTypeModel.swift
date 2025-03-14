//
//  ItemTypeModel.swift
//
//
//  Created by khushbu on 30/10/23.
//

import Foundation

public struct ItemTypeModel: Codable {
    var itemId: String
    var type: String
    var facilityId: String

    private enum CodingKeys: String, CodingKey {
        case itemId = "id"
        case type = "type"
        case facilityId = "facility_id"
    }

    public init(itemId: String, type: ItemType, facilityId: String = "") {
        self.itemId = itemId
        self.type = type.rawValue
        self.facilityId = facilityId
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        itemId = try container.decode(String.self, forKey: .itemId)
        type = try container.decode(String.self, forKey: .type)
        facilityId = try container.decodeIfPresent(String.self, forKey: .facilityId) ?? ""
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(itemId, forKey: .itemId)
        try container.encode(type, forKey: .type)
        if !facilityId.isEmpty {
            try container.encode(facilityId, forKey: .facilityId)
        }
    }
}
