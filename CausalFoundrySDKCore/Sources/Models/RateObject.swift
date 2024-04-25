//
//  RateObject.swift
//
//
//  Created by khushbu on 10/10/23.
//

import Foundation

struct RateObject: Codable {
    let rateValue: Float
    let type: String
    let subjectId: String
    let meta: Encodable?

    enum CodingKeys: String, CodingKey {
        case rate_value
        case type
        case subject_id
        case meta
    }

    init(rateValue: Float, type: String, subjectId: String, meta: Encodable? = nil) {
        self.rateValue = rateValue
        self.type = type
        self.subjectId = subjectId
        self.meta = meta
    }

    // MARK: - Encoding

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(rateValue, forKey: .rate_value)
        try container.encode(type, forKey: .type)
        try container.encode(subjectId, forKey: .subject_id)
        if let metaData = meta {
            try container.encode(metaData, forKey: .meta)
        }
    }

    // MARK: - Decoding

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        rateValue = try container.decode(Float.self, forKey: .rate_value)
        type = try container.decode(String.self, forKey: .type)
        subjectId = try container.decode(String.self, forKey: .subject_id)
        if let metaData = try container.decodeIfPresent(Data.self, forKey: .meta) {
            meta = try? (JSONSerialization.jsonObject(with: metaData, options: .allowFragments) as! any Encodable)
        } else {
            meta = nil
        }
    }
}
