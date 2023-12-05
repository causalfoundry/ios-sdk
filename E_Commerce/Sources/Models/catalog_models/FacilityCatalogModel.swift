//
//  FacilityCatalogModel.swift
//
//
//  Created by khushbu on 30/10/23.
//

import Foundation

public struct FacilityCatalogModel: Codable {
    var name: String?
    var type: String?
    var country: String?
    var region_state: String?
    var city: String?
    var is_active: Bool?
    var has_delivery: Bool?
    var is_sponsored: Bool?

    enum CodingKeys: String, CodingKey {
        case name
        case type
        case country
        case region_state
        case city
        case is_active
        case has_delivery
        case is_sponsored
    }

    public init(name: String? = nil, type: String? = nil, country: String? = nil, region_state: String? = nil, city: String? = nil, is_active: Bool? = nil, has_delivery: Bool? = nil, is_sponsored: Bool? = nil) {
        self.name = name
        self.type = type
        self.country = country
        self.region_state = region_state
        self.city = city
        self.is_active = is_active
        self.has_delivery = has_delivery
        self.is_sponsored = is_sponsored
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        type = try container.decodeIfPresent(String.self, forKey: .type)
        country = try container.decodeIfPresent(String.self, forKey: .country)
        region_state = try container.decodeIfPresent(String.self, forKey: .region_state)
        city = try container.decodeIfPresent(String.self, forKey: .city)
        is_active = try container.decodeIfPresent(Bool.self, forKey: .is_active)
        has_delivery = try container.decodeIfPresent(Bool.self, forKey: .has_delivery)
        is_sponsored = try container.decodeIfPresent(Bool.self, forKey: .is_sponsored)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(type, forKey: .type)
        try container.encode(country, forKey: .country)
        try container.encode(region_state, forKey: .region_state)
        try container.encode(city, forKey: .city)
        try container.encode(is_active, forKey: .is_active)
        try container.encode(has_delivery, forKey: .has_delivery)
        try container.encode(is_sponsored, forKey: .is_sponsored)
    }
}
