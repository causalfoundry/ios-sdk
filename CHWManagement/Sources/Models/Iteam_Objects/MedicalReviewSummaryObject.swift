//
//  MedicalReviewSummaryObject.swift
//
//
//  Created by khushbu on 07/11/23.
//

import Foundation

public struct MedicalReviewSummaryObject: Codable {
    var type: String
    var value: [String]
    var remarks: String?

    enum CodingKeys: String, CodingKey {
        case type
        case value
        case remarks
    }

    public init(type: String, value: [String], remarks: String? = nil) {
        self.type = type
        self.value = value
        self.remarks = remarks
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decode(String.self, forKey: .type)
        value = try container.decode([String].self, forKey: .value)
        remarks = try container.decodeIfPresent(String.self, forKey: .remarks)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type, forKey: .type)
        try container.encode(value, forKey: .value)
        try container.encode(remarks, forKey: .remarks)
    }
}


extension MedicalReviewSummaryObject: Sequence {
    public func makeIterator() -> IndexingIterator<[String]> {
        return value.makeIterator()
    }
}
