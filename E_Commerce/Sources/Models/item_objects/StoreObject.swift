//
//  StoreObject.swift
//
//
//  Created by moizhassankh on 06/12/23.
//

import Foundation

public struct StoreObject: Codable {
    var id: String
    var lat: Float? = 0
    var lon: Float? = 0

    // Custom coding keys enum
    enum CodingKeys: String, CodingKey {
        case id
        case lat
        case lon
    }

    public init(id: String, lat: Float? = 0, lon: Float? = 0) {
        self.id = id
        self.lat = lat
        self.lon = lon
    }

    // Custom encoding method
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(lat, forKey: .lat)
        try container.encode(lon, forKey: .lon)
    }

    // Custom decoding method
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        lat = try container.decode(Float.self, forKey: .lat)
        lon = try container.decode(Float.self, forKey: .lon)
    }
}
