//
//  MedicalReviewSummaryObject.swift
//
//
//  Created by khushbu on 07/11/23.
//

import Foundation

public struct MedicalReviewSummaryObject: Codable {
    var type: String
    var values: [String]
    var remarks: String?

    enum CodingKeys: String, CodingKey {
        case type
        case values
        case remarks
    }

    public init(type: String, values: [String], remarks: String? = nil) {
        self.type = type
        self.values = values
        self.remarks = remarks
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decode(String.self, forKey: .type)
        values = try container.decode([String].self, forKey: .values)
        remarks = try container.decodeIfPresent(String.self, forKey: .remarks)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type, forKey: .type)
        try container.encode(values, forKey: .values)
        try container.encodeIfPresent(remarks, forKey: .remarks)
    }
}

extension MedicalReviewSummaryObject: Sequence {
    public func makeIterator() -> IndexingIterator<[String]> {
        return values.makeIterator()
    }
}
