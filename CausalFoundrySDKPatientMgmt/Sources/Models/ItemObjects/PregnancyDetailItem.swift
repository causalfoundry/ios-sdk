//
//  PregnancyDetailItem.swift
//  
//
//  Created by MOIZ HASSAN KHAN on 30/4/24.
//

import Foundation

public struct PregnancyDetailItem: Codable {
    var type: String
    var value: Encodable?
    var observationDate: Int64?

    enum CodingKeys: String, CodingKey {
        case type
        case value
        case observationDate = "observation_date"
    }

    public init(type: String, value: Encodable? = nil, observationDate: Int64? = nil) {
        self.type = type
        self.value = value
        self.observationDate = observationDate
    }

    // Encoding to JSON
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type, forKey: .type)
        if let valueData = value {
            try container.encodeIfPresent(valueData, forKey: .value)
        }
        try container.encodeIfPresent(observationDate, forKey: .observationDate)
    }

    // Decoding from JSON
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decode(String.self, forKey: .type)
        if let valueData = try? container.decodeIfPresent(Data.self, forKey: .value) {
            value = try? (JSONSerialization.jsonObject(with: valueData, options: .allowFragments) as! any Encodable)
        } else {
            value = nil
        }
        observationDate = try container.decodeIfPresent(Int64.self, forKey: .observationDate)
    }
}

