//
//  RedeemObject.swift
//
//
//  Created by khushbu on 08/11/23.
//

import CausalFoundrySDKCore
import Foundation

public struct RedeemObject: Codable {
    let type: String
    let pointsWithdrawn: Float
    let convertedValue: Float
    var currency: String?
    let isSuccessful: Bool

    // Custom init method
    public init(type: RedeemType, pointsWithdrawn: Float, convertedValue: Float, isSuccessful: Bool, currency: CurrencyCode? = nil) {
        self.type = type.rawValue
        self.pointsWithdrawn = pointsWithdrawn
        self.convertedValue = convertedValue
        self.currency = currency?.rawValue ?? ""
        self.isSuccessful = isSuccessful
    }

    private enum CodingKeys: String, CodingKey {
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
        try container.encodeIfPresent(currency, forKey: .currency)
        try container.encode(isSuccessful, forKey: .isSuccessful)
    }

    // Decoding method
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decode(String.self, forKey: .type)
        pointsWithdrawn = try container.decode(Float.self, forKey: .pointsWithdrawn)
        convertedValue = try container.decode(Float.self, forKey: .convertedValue)
        currency = try container.decodeIfPresent(String.self, forKey: .currency)
        isSuccessful = try container.decode(Bool.self, forKey: .isSuccessful)
    }
}
