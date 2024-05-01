//
//  ChwSiteCatalogModel.swift
//
//
//  Created by MOIZ HASSAN KHAN on 01/05/24.
//

import Foundation

public struct HcwSiteCatalogModel: Codable {
    var name: String
    var country: String
    var regionState: String
    var city: String
    var zipcode: String
    var level: String
    var category: String
    var isActive: Bool
    var address: String
    var addressType: String
    var latitude: Double
    var longitude: Double
    var culture: String
    
    
    public enum CodingKeys: String, CodingKey {
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
    }
    

    public init(name: String = "", country: String = "", regionState: String = "", city: String = "", zipcode: String = "", level: String = "", category: String = "", isActive: Bool = true, address: String = "", addressType: String = "", latitude: Double = 0, longitude: Double = 0, culture: String = "") {
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
    }
}
