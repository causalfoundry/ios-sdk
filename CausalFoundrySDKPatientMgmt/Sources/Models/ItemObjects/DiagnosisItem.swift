//
//  DiagnosisItem.swift
//
//
//  Created by khushbu on 03/11/23.
//

import Foundation

public struct DiagnosisItem: Codable {
    var type: String
    var subType: String
    var category: String
    var value: Any?
    var unit: String
    var remarks: String?
    var observationTime: Int64?

    enum CodingKeys: String, CodingKey {
        case type
        case subType = "sub_type"
        case category
        case value
        case unit
        case remarks
        case observationTime = "observation_time"
    }

    public init(type: String, subType: String, category: String, value: Any? = nil, unit: String = "value", observationTime: Int64? = nil, remarks: String? = nil) {
        self.type = type
        self.subType = subType
        self.category = category
        self.value = value
        self.unit = unit
        self.remarks = remarks
        self.observationTime = observationTime
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decode(String.self, forKey: .type)
        subType = try container.decode(String.self, forKey: .subType)
        category = try container.decode(String.self, forKey: .category)
        unit = try container.decode(String.self, forKey: .unit)
        remarks = try container.decodeIfPresent(String.self, forKey: .remarks)
        observationTime = try container.decodeIfPresent(Int64.self, forKey: .observationTime)
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

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type, forKey: .type)
        try container.encode(subType, forKey: .subType)
        try container.encode(category, forKey: .category)
        try container.encode(unit, forKey: .unit)
        try container.encodeIfPresent(remarks, forKey: .remarks)
        try container.encodeIfPresent(observationTime, forKey: .observationTime)
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
}
