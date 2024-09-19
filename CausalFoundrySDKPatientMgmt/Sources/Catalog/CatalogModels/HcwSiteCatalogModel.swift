//
//  ChwSiteCatalogModel.swift
//
//
//  Created by MOIZ HASSAN KHAN on 01/05/24.
//

import Foundation

public struct HcwSiteCatalogModel: Codable {
    var siteId: String
    var name: String?
    var country: String?
    var regionState: String?
    var city: String?
    var zipcode: String?
    var level: String?
    var category: String?
    var isActive: Bool?
    var address: String?
    var addressType: String?
    var latitude: Double?
    var longitude: Double?
    var culture: String?
    var parentSiteId: String?
    
    
    public enum CodingKeys: String, CodingKey {
        case siteId = "id"
        case name
        case country
        case regionState = "region_state"
        case city
        case zipcode
        case level
        case category
        case isActive = "is_active"
        case address
        case addressType = "address_type"
        case latitude
        case longitude
        case culture
        case parentSiteId = "parent_site_id"
    }
    

    public init(siteId: String, name: String? = "", country: String? = "", regionState: String? = "", city: String? = "", zipcode: String? = "", level: String? = "", category: String? = "", isActive: Bool? = true, address: String? = "", addressType: String? = "", latitude: Double? = 0, longitude: Double? = 0, culture: String? = "", parentSiteId: String? = "") {
        self.siteId = siteId
        self.name = name
        self.country = country
        self.regionState = regionState
        self.city = city
        self.zipcode = zipcode
        self.level = level
        self.category = category
        self.isActive = isActive
        self.address = address
        self.addressType = addressType
        self.latitude = latitude
        self.longitude = longitude
        self.culture = culture
        self.parentSiteId = parentSiteId
    }
    
    
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(siteId, forKey: .siteId)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(country, forKey: .country)
        try container.encodeIfPresent(regionState, forKey: .regionState)
        try container.encodeIfPresent(city, forKey: .city)
        try container.encodeIfPresent(zipcode, forKey: .zipcode)
        try container.encodeIfPresent(level, forKey: .level)
        try container.encodeIfPresent(category, forKey: .category)
        try container.encodeIfPresent(isActive, forKey: .isActive)
        try container.encodeIfPresent(address, forKey: .address)
        try container.encodeIfPresent(addressType, forKey: .addressType)
        try container.encodeIfPresent(latitude, forKey: .latitude)
        try container.encodeIfPresent(longitude, forKey: .longitude)
        try container.encodeIfPresent(culture, forKey: .culture)
        try container.encodeIfPresent(parentSiteId, forKey: .parentSiteId)
        
    }

    // Decoding
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        siteId = try container.decode(String.self, forKey: .siteId)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        country = try container.decodeIfPresent(String.self, forKey: .country)
        regionState = try container.decodeIfPresent(String.self, forKey: .regionState)
        city = try container.decodeIfPresent(String.self, forKey: .city)
        zipcode = try container.decodeIfPresent(String.self, forKey: .zipcode)
        level = try container.decodeIfPresent(String.self, forKey: .level)
        category = try container.decodeIfPresent(String.self, forKey: .category)
        isActive = try container.decodeIfPresent(Bool.self, forKey: .isActive)
        address = try container.decodeIfPresent(String.self, forKey: .address)
        addressType = try container.decodeIfPresent(String.self, forKey: .addressType)
        latitude = try container.decodeIfPresent(Double.self, forKey: .latitude)
        longitude = try container.decodeIfPresent(Double.self, forKey: .longitude)
        culture = try container.decodeIfPresent(String.self, forKey: .culture)
        parentSiteId = try container.decodeIfPresent(String.self, forKey: .parentSiteId)
        
    }

    
}

