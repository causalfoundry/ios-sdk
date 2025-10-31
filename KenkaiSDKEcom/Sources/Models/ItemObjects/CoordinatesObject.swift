//
//  CoordinatesObject.swift
//  
//
//  Created by MOIZ HASSAN KHAN on 26/4/24.
//

import Foundation

public struct CoordinatesObject: Codable {
    var lat: Double? = 0
    var lng: Double? = 0

    // Custom coding keys enum
    enum CodingKeys: String, CodingKey {
        case lat
        case lng
    }

    public init(lat: Double? = 0, lng: Double? = 0) {
        self.lat = lat
        self.lng = lng
    }

    // Custom encoding method
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(lat, forKey: .lat)
        try container.encode(lng, forKey: .lng)
    }

    // Custom decoding method
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        lat = try container.decode(Double.self, forKey: .lat)
        lng = try container.decode(Double.self, forKey: .lng)
    }
}
