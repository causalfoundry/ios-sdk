//
//  ChwSiteCatalogModel.swift
//
//
//  Created by khushbu on 26/10/23.
//

import Foundation

public struct ChwSiteCatalogModel: Codable {
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
    var latitude: Float
    var longitude: Float
    var culture: String

    public init(name: String, country: String, regionState: String, city: String, zipcode: String, level: String, category: String, isActive: Bool, address: String, addressType: String, latitude: Float, longitude: Float, culture: String) {
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
