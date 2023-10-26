//
//  ChwModelObject.swift
//
//
//  Created by khushbu on 26/10/23.
//


import Foundation

struct ChwModelObject: Codable {
    var type: String
    var meta: Any?

    init(type: String, meta: Any? = nil) {
        self.type = type
        self.meta = meta
    }

   
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type, forKey: .type)
        try container.encode(meta as? String, forKey: .meta)
    }

    // Decoding
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decode(String.self, forKey: .type)
        meta = try container.decodeIfPresent(String.self, forKey: .meta)
    }

    enum CodingKeys: String, CodingKey {
        case type
        case meta
    }
}

