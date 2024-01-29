//
//  LevelObject.swift
//
//
//  Created by khushbu on 07/11/23.
//

import Foundation

struct LevelObject: Codable {
    let prevLevel: Int
    let newLevel: Int
    let moduleId: String
    let meta: Encodable?

    // Custom init method
    init(prevLevel: Int, newLevel: Int, moduleId: String?, meta: Encodable?) {
        self.prevLevel = prevLevel
        self.newLevel = newLevel
        self.moduleId = (moduleId != nil) ? moduleId! : ""
        self.meta = meta
    }

    enum CodingKeys: String, CodingKey {
        case prevLevel = "prev_level"
        case newLevel = "new_level"
        case moduleId = "module_id"
        case meta
    }

    // Encoding method
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(prevLevel, forKey: .prevLevel)
        try container.encode(newLevel, forKey: .newLevel)
        try container.encode(moduleId, forKey: .moduleId)
        if let metaData = meta {
            try container.encode(metaData, forKey: .meta)
        }
    }

    // Decoding method
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        prevLevel = try container.decode(Int.self, forKey: .prevLevel)
        newLevel = try container.decode(Int.self, forKey: .newLevel)
        moduleId = try container.decodeIfPresent(String.self, forKey: .moduleId)!
        if let metaData = try? container.decodeIfPresent(Data.self, forKey: .meta) {
            meta = try? (JSONSerialization.jsonObject(with: metaData, options: .allowFragments) as! any Encodable)
        } else {
            meta = nil
        }
    }
}
