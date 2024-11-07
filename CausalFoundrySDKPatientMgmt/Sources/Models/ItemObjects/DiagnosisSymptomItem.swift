//
//  DiagnosisSymptomItem.swift
//
//
//  Created by khushbu on 03/11/23.
//

import Foundation

import Foundation

public struct DiagnosisSymptomItem: Codable {
    var type: String
    var symptomsList: [String]
    var remarks: String?

    enum CodingKeys: String, CodingKey {
        case type
        case symptomsList = "symptoms_list"
        case remarks
    }

    public init(type: String, symptomsList: [String] = [], remarks: String? = nil) {
        self.type = type
        self.symptomsList = symptomsList
        self.remarks = remarks
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decode(String.self, forKey: .type)
        symptomsList = try container.decode([String].self, forKey: .symptomsList)
        remarks = try container.decodeIfPresent(String.self, forKey: .remarks)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type, forKey: .type)
        try container.encode(symptomsList, forKey: .symptomsList)
        try container.encodeIfPresent(remarks, forKey: .remarks)
    }
}
