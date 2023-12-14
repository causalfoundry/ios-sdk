//
//  ItemTypeModel.swift
//
//
//  Created by khushbu on 30/10/23.
//

import Foundation

public struct ItemTypeModel: Codable {
    var item_id: String
    var item_type: String
    var facility_id: String

    enum CodingKeys: String, CodingKey {
        case item_id = "id"
        case item_type = "type"
        case facility_id
    }

    public init(item_id: String, item_type: String, facility_id: String = "") {
        self.item_id = item_id
        self.item_type = item_type
        self.facility_id = facility_id
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        item_id = try container.decode(String.self, forKey: .item_id)
        item_type = try container.decode(String.self, forKey: .item_type)
        facility_id = try container.decodeIfPresent(String.self, forKey: .facility_id) ?? ""
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(item_id, forKey: .item_id)
        try container.encode(item_type, forKey: .item_type)
        if !facility_id.isEmpty {
            try container.encode(facility_id, forKey: .facility_id)
        }
    }
}
