//
//  RedeemObject.swift
//
//
//  Created by khushbu on 08/11/23.
//

import Foundation


import Foundation

struct RedeemObject: Codable {
    let type: String
    let points_withdrawn: Float
    let converted_value: Float?
    let currency: String?
    let is_successful: Bool?

    // Custom init method
    init(type: String, points_withdrawn: Float, converted_value: String?, currency: String?,is_successful:Bool) {
        self.type = type
        self.points_withdrawn = points_withdrawn
        self.converted_value = converted_value
        self.currency = currency
        self.is_successful = is_successful
    }
    
    enum CodingKeys: String, CodingKey {
        case type
        case points_withdrawn
        case converted_value
        case currency
        case is_successful
    }
    
    // Encoding method
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type, forKey: .type)
        try container.encode(points_withdrawn, forKey: .points_withdrawn)
        try container.encode(converted_value, forKey: .converted_value)
        try container.encode(currency, forKey: .currency)
        try container.encode(is_successful, forKey: .is_successful)
    }
    
    // Decoding method
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decodeIfPresent(String.self, forKey: .type)
        points_withdrawn = try container.decodeIfPresent(Float.self, forKey: .points_withdrawn)
        converted_value = try container.decodeIfPresent(Float.self, forKey: .converted_value)
        currency = try container.decodeIfPresent(String.self, forKey: .currency)
        is_successful = try container.decodeIfPresent(Bool.self, forKey: .is_successful)
        
    }
}
