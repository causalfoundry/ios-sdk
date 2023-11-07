//
//  PatientStatusItem.swift
//
//
//  Created by khushbu on 04/11/23.
//

import Foundation


public struct PatientStatusItem: Codable {
    var type: String
    var value: String
    var diagnosisYear: String
    var diagnosisType: String
    var remarks: String?
    
    enum CodingKeys: String, CodingKey {
        case type
        case value
        case diagnosisYear = "diagnosis_year"
        case diagnosisType = "diagnosis_type"
        case remarks
    }

     public init(type: String, value: String, diagnosisYear: String = "", diagnosisType: String = "", remarks: String? = nil) {
        self.type = type
        self.value = value
        self.diagnosisYear = diagnosisYear
        self.diagnosisType = diagnosisType
        self.remarks = remarks
    }

    // Encoding to JSON
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type, forKey: .type)
        try container.encode(value, forKey: .value)
        try container.encode(diagnosisYear, forKey: .diagnosisYear)
        try container.encode(diagnosisType, forKey: .diagnosisType)
        try container.encode(remarks, forKey: .remarks)
    }

    // Decoding from JSON
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decode(String.self, forKey: .type)
        value = try container.decode(String.self, forKey: .value)
        diagnosisYear = try container.decodeIfPresent(String.self, forKey: .diagnosisYear) ?? ""
        diagnosisType = try container.decodeIfPresent(String.self, forKey: .diagnosisType) ?? ""
        remarks = try container.decodeIfPresent(String.self, forKey: .remarks)
    }
}
