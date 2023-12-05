//
//  StoreObject.swift
//
//
//  Created by khushbu on 01/11/23.
//

import Foundation


public struct StoreObject: Codable {
    var id: String
    var lat: Float
    var lon: Float

    // Custom coding keys enum
    enum CodingKeys: String, CodingKey {
        case id
        case lat = "latitude"
        case lon = "longitude"
    }

    
    public  init(id: String, lat: Float, lon: Float) {
        self.id = id
        self.lat = lat
        self.lon = lon
    }
    
    // Encoding method
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(lat, forKey: .lat)
        try container.encode(lon, forKey: .lon)
    }

//    // Decoding method
    public  init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        lat = try container.decode(Float.self, forKey: .lat)
        lon = try container.decode(Float.self, forKey: .lon)
    }
}
