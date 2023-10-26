//
//  ChwSiteCatalogModel.swift
//
//
//  Created by khushbu on 26/10/23.
//

import Foundation

struct ChwSiteCatalogModel: Codable {
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
}
