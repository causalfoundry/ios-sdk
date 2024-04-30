//
//  DiagnosisItem.swift
//
//
//  Created by khushbu on 03/11/23.
//

import Foundation

public struct DiagnosisItem: Codable {
    var type: String
    var value: Encodable?
    var unit: String
    var remarks: String?
    var diagnosisDate: Int64?

    enum CodingKeys: String, CodingKey {
        case type
        case value
        case unit
        case remarks
        case diagnosisDate = "diagnosis_date"
    }

    public init(type: String, value: Encodable? = nil, unit: String = "value", remarks: String? = nil, diagnosisDate: Int64? = nil) {
        self.type = type
        self.value = value
        self.unit = unit
        self.remarks = remarks
        self.diagnosisDate = diagnosisDate
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decode(String.self, forKey: .type)
        if let valueData = try? container.decodeIfPresent(Data.self, forKey: .value) {
            value = try? (JSONSerialization.jsonObject(with: valueData, options: .allowFragments) as! any Encodable)
        } else {
            value = nil
        }
        unit = try container.decode(String.self, forKey: .unit)
        remarks = try container.decodeIfPresent(String.self, forKey: .remarks)
        diagnosisDate = try container.decodeIfPresent(Int64.self, forKey: .diagnosisDate)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type, forKey: .type)
        if let valueData = value {
            try container.encodeIfPresent(valueData, forKey: .value)
        }
        try container.encode(unit, forKey: .unit)
        try container.encodeIfPresent(remarks, forKey: .remarks)
        try container.encodeIfPresent(diagnosisDate, forKey: .diagnosisDate)
    }
}
