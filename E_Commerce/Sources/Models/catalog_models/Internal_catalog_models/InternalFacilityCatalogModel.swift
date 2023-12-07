//
//  InternalFacilityCatalogModel.swift
//
//
//  Created by moizhassankh on 07/12/23.
//

import Foundation

struct InternalFacilityCatalogModel: Codable {
    var id: String
    var name: String
    var type: String?
    var country: String?
    var regionState: String?
    var city: String?
    var isActive: Bool?
    var hasDelivery: Bool?
    var isSponsored: Bool?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case type
        case country
        case regionState = "region_state"
        case city
        case isActive = "is_active"
        case hasDelivery = "has_delivery"
        case isSponsored = "is_sponsored"
    }

    public init(id: String, name: String, type: String? = "", country: String? = "", regionState: String? = "", city: String? = "", isActive: Bool? = nil, hasDelivery: Bool? = nil, isSponsored: Bool? = nil) {
        self.id = id
        self.name = name
        self.type = type
        self.country = country
        self.regionState = regionState
        self.city = city
        self.isActive = isActive
        self.hasDelivery = hasDelivery
        self.isSponsored = isSponsored
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        type = try container.decodeIfPresent(String.self, forKey: .type)
        country = try container.decodeIfPresent(String.self, forKey: .country)
        regionState = try container.decodeIfPresent(String.self, forKey: .regionState)
        city = try container.decodeIfPresent(String.self, forKey: .city)
        isActive = try container.decodeIfPresent(Bool.self, forKey: .isActive)
        hasDelivery = try container.decodeIfPresent(Bool.self, forKey: .hasDelivery)
        isSponsored = try container.decodeIfPresent(Bool.self, forKey: .isSponsored)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encodeIfPresent(type, forKey: .type)
        try container.encodeIfPresent(country, forKey: .country)
        try container.encodeIfPresent(regionState, forKey: .regionState)
        try container.encodeIfPresent(city, forKey: .city)
        try container.encodeIfPresent(isActive, forKey: .isActive)
        try container.encodeIfPresent(hasDelivery, forKey: .hasDelivery)
        try container.encodeIfPresent(isSponsored, forKey: .isSponsored)
    }
}

