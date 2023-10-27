//
//  File.swift
//  
//
//  Created by khushbu on 26/10/23.
//

import Foundation

public struct InvestigationItem: Codable,Equatable {
   public var name: String
    public var testValue: String
    public var testUnit: String
    public var orderedDate: Int64
    public var testedDate: Int64
    public var action: String
    public var remarks: String?

    enum CodingKeys: String, CodingKey {
        case name
        case testValue = "test_value"
        case testUnit = "test_unit"
        case orderedDate = "ordered_date"
        case testedDate = "tested_date"
        case action
        case remarks
    }

   public init(name: String, testValue: String, testUnit: String, orderedDate: Int64, testedDate: Int64, action: String, remarks: String?) {
        self.name = name
        self.testValue = testValue
        self.testUnit = testUnit
        self.orderedDate = orderedDate
        self.testedDate = testedDate
        self.action = action
        self.remarks = remarks
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        testValue = try container.decode(String.self, forKey: .testValue)
        testUnit = try container.decode(String.self, forKey: .testUnit)
        orderedDate = try container.decode(Int64.self, forKey: .orderedDate)
        testedDate = try container.decode(Int64.self, forKey: .testedDate)
        action = try container.decode(String.self, forKey: .action)
        remarks = try container.decodeIfPresent(String.self, forKey: .remarks)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(testValue, forKey: .testValue)
        try container.encode(testUnit, forKey: .testUnit)
        try container.encode(orderedDate, forKey: .orderedDate)
        try container.encode(testedDate, forKey: .testedDate)
        try container.encode(action, forKey: .action)
        try container.encode(remarks, forKey: .remarks)
    }
}
