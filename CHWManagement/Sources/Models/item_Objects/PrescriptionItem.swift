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
    var type: String
    var frequency: String
    var prescribedDays: Int
    var action: String
    var remarks: String?

    private enum CodingKeys: String, CodingKey {
        case drugId = "id"
        case name
        case dosageValue
        case dosageUnit
        case type
        case frequency
        case prescribedDays
        case action
        case remarks
    }

   public  init(drugId: String, name: String, dosageValue: Float = 0.0, dosageUnit: String, type: String, frequency: String, prescribedDays: Int = 0, action: String, remarks: String? = nil) {
        self.drugId = drugId
        self.name = name
        self.dosageValue = dosageValue
        self.dosageUnit = dosageUnit
        self.type = type
        self.frequency = frequency
        self.prescribedDays = prescribedDays
        self.action = action
        self.remarks = remarks
    }
    // Encode the struct to JSON data
       public func encode(to encoder: Encoder) throws {
           var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(drugId, forKey: .drugId)
            try container.encode(name, forKey: .name)
            try container.encode(dosageValue, forKey: .dosageValue)
            try container.encode(dosageUnit, forKey: .dosageUnit)
            try container.encode(type, forKey: .type)
            try container.encode(frequency, forKey: .frequency)
            try container.encode(prescribedDays, forKey: .prescribedDays)
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
            type = try container.decode(String.self, forKey: .type)
            frequency = try container.decode(String.self, forKey: .frequency)
            prescribedDays = try container.decode(Int.self, forKey: .prescribedDays)
            action = try container.decode(String.self, forKey: .action)
            remarks = try container.decodeIfPresent(String.self, forKey: .remarks)
        }
}
