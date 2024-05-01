//
//  PregnancyDetailItem.swift
//  
//
//  Created by MOIZ HASSAN KHAN on 30/4/24.
//

import Foundation

public struct PregnancyDetailItem: Codable {
    var type: String
    var value: Any?
    var observationDate: Int64?

    enum CodingKeys: String, CodingKey {
        case type
        case value
        case observationDate = "observation_date"
    }

    public init(type: String, value: Any? = nil, observationDate: Int64? = nil) {
        self.type = type
        self.value = value
        self.observationDate = observationDate
    }

    // Encoding to JSON
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type, forKey: .type)
        try container.encodeIfPresent(observationDate, forKey: .observationDate)
        if let value = value {
            if let intValue = value as? Int {
                try container.encode(intValue, forKey: .value)
            } else if let doubleValue = value as? Double {
                try container.encode(doubleValue, forKey: .value)
            } else if let stringValue = value as? String {
                try container.encode(stringValue, forKey: .value)
            } else if let boolValue = value as? Bool {
                try container.encode(boolValue, forKey: .value)
            } else if let dateValue = value as? Date {
                try container.encode(dateValue, forKey: .value)
            }
        }
    }

    // Decoding from JSON
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decode(String.self, forKey: .type)
        observationDate = try container.decodeIfPresent(Int64.self, forKey: .observationDate)
        if let intValue = try? container.decodeIfPresent(Int.self, forKey: .value) {
            value = intValue
        } else if let doubleValue = try? container.decodeIfPresent(Double.self, forKey: .value) {
            value = doubleValue
        } else if let stringValue = try? container.decodeIfPresent(String.self, forKey: .value) {
            value = stringValue
        } else if let boolValue = try? container.decodeIfPresent(Bool.self, forKey: .value) {
            value = boolValue
        } else if let dateValue = try? container.decodeIfPresent(Date.self, forKey: .value) {
            value = dateValue
        }
    }
}

