//
//  File.swift
//  
//
//  Created by MOIZ HASSAN KHAN on 30/8/24.
//

import Foundation

public struct DiagnosisOutcomeItem: Codable {
    var type: String
    var subType: String?
    var value: Any?
    var remarks: String?

    enum CodingKeys: String, CodingKey {
        case type
        case subType = "sub_type"
        case value
        case remarks
    }

    public init(type: String, subType: String? = "", value: Any? = nil, remarks: String? = nil) {
        self.type = type
        self.subType = subType
        self.value = value
        self.remarks = remarks
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decode(String.self, forKey: .type)
        subType = try container.decodeIfPresent(String.self, forKey: .subType)
        remarks = try container.decodeIfPresent(String.self, forKey: .remarks)
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
        try container.encodeIfPresent(subType, forKey: .subType)
        try container.encodeIfPresent(remarks, forKey: .remarks)
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

