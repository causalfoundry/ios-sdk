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
    var symptoms: [String]
    var remarks: String?

    enum CodingKeys: String, CodingKey {
        case type
        case symptoms
        case remarks
    }

    public init(type: String, symptoms: [String] = [], remarks: String? = nil) {
        self.type = type
        self.symptoms = symptoms
        self.remarks = remarks
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decode(String.self, forKey: .type)
        symptoms = try container.decode([String].self, forKey: .symptoms)
        remarks = try container.decodeIfPresent(String.self, forKey: .remarks)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type, forKey: .type)
        try container.encode(symptoms, forKey: .symptoms)
        try container.encodeIfPresent(remarks, forKey: .remarks)
    }
}
