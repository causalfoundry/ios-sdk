//
//  DiagnosisItem.swift
//
//
//  Created by khushbu on 03/11/23.
//

import Foundation


public struct DiagnosisItem: Codable {
    var type: String
    var value: String
    var unit: String
    var remarks: String?

    enum CodingKeys: String, CodingKey {
        case type
        case value
        case unit
        case remarks
    }

    public init(type: String, value: String, unit: String = "value", remarks: String? = nil) {
        self.type = type
        self.value = value
        self.unit = unit
        self.remarks = remarks
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decode(String.self, forKey: .type)
        value = try container.decode(String.self, forKey: .value)
        unit = try container.decode(String.self, forKey: .unit)
        remarks = try container.decodeIfPresent(String.self, forKey: .remarks)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type, forKey: .type)
        try container.encode(value, forKey: .value)
        try container.encode(unit, forKey: .unit)
        try container.encodeIfPresent(remarks, forKey: .remarks)
    }
}
