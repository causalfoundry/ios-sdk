//
//  TreatmentPlanItem.swift
//
//
//  Created by khushbu on 04/11/23.
//

import Foundation

public struct TreatmentPlanItem: Codable {
    var type: String
    var value: Int
    var frequency: String
    var action: String
    var isApproved: Bool?
    var remarks: String?

    enum CodingKeys: String, CodingKey {
        case type
        case value
        case frequency
        case action
        case isApproved = "is_approved"
        case remarks
    }

    public init(type: String, value: Int, frequency: String, action: String, isApproved: Bool, remarks: String? = nil) {
        self.type = type
        self.value = value
        self.frequency = frequency
        self.action = action
        self.isApproved = isApproved
        self.remarks = remarks
    }

    // Encoding to JSON
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type, forKey: .type)
        try container.encode(value, forKey: .value)
        try container.encode(frequency, forKey: .frequency)
        try container.encode(action, forKey: .action)
        try container.encode(isApproved, forKey: .isApproved)
        try container.encode(remarks, forKey: .remarks)
    }

    // Decoding from JSON
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decode(String.self, forKey: .type)
        value = try container.decode(Int.self, forKey: .value)
        frequency = try container.decode(String.self, forKey: .frequency)
        action = try container.decode(String.self, forKey: .action)
        isApproved = try container.decode(Bool.self, forKey: .isApproved)
        remarks = try container.decodeIfPresent(String.self, forKey: .remarks)
    }
}
