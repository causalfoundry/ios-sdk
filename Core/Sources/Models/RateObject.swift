//
//  RateObject.swift
//
//
//  Created by khushbu on 10/10/23.
//

import Foundation

struct RateObject: Codable {
    let rate_value: Float
    let type: String
    let subject_id: String
    let meta: Encodable?
    
    enum CodingKeys: String, CodingKey {
        case rate_value
        case type
        case subject_id
        case meta
    }
    
    init(rate_value: Float, type: String, subject_id: String, meta: Encodable? = nil) {
        self.rate_value = rate_value
        self.type = type
        self.subject_id = subject_id
        self.meta = meta
    }
    
    // MARK: - Encoding
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(rate_value, forKey: .rate_value)
        try container.encode(type, forKey: .type)
        try container.encode(subject_id, forKey: .subject_id)
        if let metaData = meta {
            try container.encode(metaData, forKey: .meta)
        }
    }
    
    // MARK: - Decoding
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        rate_value = try container.decode(Float.self, forKey: .rate_value)
        type = try container.decode(String.self, forKey: .type)
        subject_id = try container.decode(String.self, forKey: .subject_id)
        if let metaData = try container.decodeIfPresent(Data.self, forKey: .meta) {
            meta = try? (JSONSerialization.jsonObject(with: metaData, options: .allowFragments) as! any Encodable)
        } else {
            meta = nil
        }
        
    }
}
