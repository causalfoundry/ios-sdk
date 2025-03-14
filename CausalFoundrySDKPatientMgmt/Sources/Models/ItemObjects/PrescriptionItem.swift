//
//  PrescriptionItem.swift
//
//
//  Created by khushbu on 03/11/23.
//

import Foundation

public struct PrescriptionItem: Codable {
    var drugId: String
    var name: String
    var dosageValue: Float
    var dosageUnit: String
    var formulation: String
    var type: String
    var frequency: String
    var prescribedDays: Int
    var dispensedDays: Int
    var prescriptionDate: Int64?
    var action: String
    var remarks: String?

    private enum CodingKeys: String, CodingKey {
        case drugId = "id"
        case name
        case dosageValue = "dosage_value"
        case dosageUnit = "dosage_unit"
        case formulation
        case type
        case frequency
        case prescribedDays = "prescribed_days"
        case dispensedDays = "dispensed_days"
        case prescriptionDate = "prescription_date"
        case action
        case remarks
    }

    public init(drugId: String, name: String, dosageValue: Float = 0.0, dosageUnit: String, formulation: PrescriptionFormulationType, type: DiagnosisType, frequency: PrescriptionItemFrequency, prescribedDays: Int = 0, dispensedDays: Int = 0, prescriptionDate: Int64? = 0, action: HcwItemAction, remarks: String? = nil) {
        self.drugId = drugId
        self.name = name
        self.dosageValue = dosageValue
        self.dosageUnit = dosageUnit
        self.formulation = formulation.rawValue
        self.type = type.rawValue
        self.frequency = frequency.rawValue
        self.prescribedDays = prescribedDays
        self.dispensedDays = dispensedDays
        self.prescriptionDate = prescriptionDate
        self.action = action.rawValue
        self.remarks = remarks
    }

    // Encode the struct to JSON data
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(drugId, forKey: .drugId)
        try container.encode(name, forKey: .name)
        try container.encode(dosageValue, forKey: .dosageValue)
        try container.encode(dosageUnit, forKey: .dosageUnit)
        try container.encode(formulation, forKey: .formulation)
        try container.encode(type, forKey: .type)
        try container.encode(frequency, forKey: .frequency)
        try container.encode(prescribedDays, forKey: .prescribedDays)
        try container.encode(dispensedDays, forKey: .dispensedDays)
        try container.encode(prescriptionDate, forKey: .prescriptionDate)
        try container.encode(action, forKey: .action)
        try container.encode(remarks, forKey: .remarks)
    }

    // Initialize a struct instance from decoded JSON data
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        drugId = try container.decode(String.self, forKey: .drugId)
        name = try container.decode(String.self, forKey: .name)
        dosageValue = try container.decode(Float.self, forKey: .dosageValue)
        dosageUnit = try container.decode(String.self, forKey: .dosageUnit)
        formulation = try container.decode(String.self, forKey: .formulation)
        type = try container.decode(String.self, forKey: .type)
        frequency = try container.decode(String.self, forKey: .frequency)
        prescribedDays = try container.decode(Int.self, forKey: .prescribedDays)
        dispensedDays = try container.decode(Int.self, forKey: .dispensedDays)
        prescriptionDate = try container.decodeIfPresent(Int64.self, forKey: .prescriptionDate)
        action = try container.decode(String.self, forKey: .action)
        remarks = try container.decodeIfPresent(String.self, forKey: .remarks)
    }
}
