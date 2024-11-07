//
//  MedicationAdherenceObject.swift
//  
//
//  Created by MOIZ HASSAN KHAN on 30/4/24.
//

import Foundation

public struct TreatmentAdherenceItem: Codable {
    var type: String
    var medicationAdherence: String
    var lackAdherenceReason: String?
    var remarks: String?

    enum CodingKeys: String, CodingKey {
        case type = "type"
        case medicationAdherence = "medication_adherence"
        case lackAdherenceReason = "lack_adherence_reason"
        case remarks = "remarks"
    }

    public init(type: String = "", medicationAdherence: String = "", lackAdherenceReason: String? = "", remarks: String? = "") {
        self.type = type
        self.medicationAdherence = medicationAdherence
        self.lackAdherenceReason = lackAdherenceReason
        self.remarks = remarks
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decode(String.self, forKey: .type)
        medicationAdherence = try container.decode(String.self, forKey: .medicationAdherence)
        lackAdherenceReason = try container.decodeIfPresent(String.self, forKey: .lackAdherenceReason)
        remarks = try container.decodeIfPresent(String.self, forKey: .remarks)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type, forKey: .type)
        try container.encode(medicationAdherence, forKey: .medicationAdherence)
        try container.encodeIfPresent(lackAdherenceReason, forKey: .lackAdherenceReason)
        try container.encodeIfPresent(remarks, forKey: .remarks)
    }
}
