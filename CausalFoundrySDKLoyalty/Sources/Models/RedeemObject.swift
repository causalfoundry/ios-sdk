//
//  RedeemObject.swift
//
//
//  Created by khushbu on 08/11/23.
//

import Foundation

import Foundation

public struct RedeemObject: Codable {
    let type: String
    let pointsWithdrawn: Float
    let convertedValue: Float?
    var currency: String?
    let isSuccessful: Bool?

    // Custom init method
    public init(type: String, pointsWithdrawn: Float, convertedValue: Float?, currency: String? = nil, isSuccessful: Bool) {
        self.type = type
        self.pointsWithdrawn = pointsWithdrawn
        self.convertedValue = convertedValue
        self.currency = currency
        self.isSuccessful = isSuccessful
    }

    public enum CodingKeys: String, CodingKey {
        case type
        case pointsWithdrawn = "points_withdrawn"
        case convertedValue = "converted_value"
        case currency
        case isSuccessful = "is_successful"
    }

    // Encoding method
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type, forKey: .type)
        try container.encode(pointsWithdrawn, forKey: .pointsWithdrawn)
        try container.encode(convertedValue, forKey: .convertedValue)
        try container.encode(currency, forKey: .currency)
        try container.encode(isSuccessful, forKey: .isSuccessful)
    }

    // Decoding method
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decodeIfPresent(String.self, forKey: .type)!
        pointsWithdrawn = try container.decodeIfPresent(Float.self, forKey: .pointsWithdrawn)!
        convertedValue = try container.decodeIfPresent(Float.self, forKey: .convertedValue)
        currency = try container.decodeIfPresent(String.self, forKey: .currency)
        isSuccessful = try container.decodeIfPresent(Bool.self, forKey: .isSuccessful)
    }
}
