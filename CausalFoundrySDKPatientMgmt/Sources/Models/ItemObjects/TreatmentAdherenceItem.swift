//
//  MedicationAdherenceObject.swift
//  
//
//  Created by MOIZ HASSAN KHAN on 30/4/24.
//

import Foundation

public struct TreatmentAdherenceItem: Codable {
    var medicationAdherence: String?
    var lackAdherenceReason: String?

    enum CodingKeys: String, CodingKey {
        case medicationAdherence = "medication_adherence"
        case lackAdherenceReason = "lack_adherence_reason"
    }

    public init(medicationAdherence: String? = "", lackAdherenceReason: String? = "") {
        self.medicationAdherence = medicationAdherence
        self.lackAdherenceReason = lackAdherenceReason
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        medicationAdherence = try container.decode(String.self, forKey: .medicationAdherence)
        lackAdherenceReason = try container.decodeIfPresent(String.self, forKey: .lackAdherenceReason)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(medicationAdherence, forKey: .medicationAdherence)
        try container.encodeIfPresent(lackAdherenceReason, forKey: .lackAdherenceReason)
    }
}
