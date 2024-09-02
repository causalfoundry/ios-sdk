//
//  File.swift
//  
//
//  Created by MOIZ HASSAN KHAN on 30/8/24.
//

import Foundation

public struct ScheduleItem: Codable {
    var type: String
    var subType: String
    var value: Int
    var frequency: String
    var action: String
    var remarks: String?
    var startDate: Int64?
    var endDate: Int64?


    enum CodingKeys: String, CodingKey {
        case type
        case subType = "sub_type"
        case value
        case frequency
        case action
        case remarks
        case startDate = "start_date"
        case endDate = "end_date"

    }

    public init(type: String, subType: String, value: Int, frequency: String, action: String, remarks: String? = "", startDate: Int64? = nil, endDate: Int64? = nil) {
        self.type = type
        self.subType = subType
        self.value = value
        self.frequency = frequency
        self.action = action
        self.remarks = remarks
        self.startDate = startDate
        self.endDate = endDate

    }

    // Encoding to JSON
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type, forKey: .type)
        try container.encode(subType, forKey: .subType)
        try container.encode(value, forKey: .value)
        try container.encode(frequency, forKey: .frequency)
        try container.encode(action, forKey: .action)
        try container.encodeIfPresent(remarks, forKey: .remarks)
        try container.encodeIfPresent(startDate, forKey: .startDate)
        try container.encodeIfPresent(endDate, forKey: .endDate)

    }

    // Decoding from JSON
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decode(String.self, forKey: .type)
        subType = try container.decode(String.self, forKey: .subType)
        value = try container.decode(Int.self, forKey: .value)
        frequency = try container.decode(String.self, forKey: .frequency)
        action = try container.decode(String.self, forKey: .action)
        remarks = try container.decodeIfPresent(String.self, forKey: .remarks)
        startDate = try container.decodeIfPresent(Int64.self, forKey: .startDate)
        endDate = try container.decodeIfPresent(Int64.self, forKey: .endDate)

    }
}

