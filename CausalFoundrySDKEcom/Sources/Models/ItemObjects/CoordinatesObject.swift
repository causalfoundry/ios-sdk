//
//  CoordinatesObject.swift
//  
//
//  Created by MOIZ HASSAN KHAN on 26/4/24.
//

import Foundation

public struct CoordinatesObject: Codable {
    var lat: Double? = 0
    var lon: Double? = 0

    // Custom coding keys enum
    enum CodingKeys: String, CodingKey {
        case lat
        case lon
    }

    public init(lat: Double? = 0, lon: Double? = 0) {
        self.lat = lat
        self.lon = lon
    }

    // Custom encoding method
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(lat, forKey: .lat)
        try container.encode(lon, forKey: .lon)
    }

    // Custom decoding method
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        lat = try container.decode(Double.self, forKey: .lat)
        lon = try container.decode(Double.self, forKey: .lon)
    }
}
