//
//  MediaObject.swift
//
//
//  Created by khushbu on 09/10/23.
//

import Foundation

struct MediaObject: Codable {
    var id: String
    var type: String
    var action: String
    var time: Int
    var meta: Encodable?

    init(id: String, type: String, action: String, time: Int, meta: Encodable? = nil) {
        self.id = id
        self.type = type
        self.action = action
        self.time = time
        self.meta = meta
    }

    enum CodingKeys: String, CodingKey {
        case id
        case type
        case action
        case time
        case meta
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        type = try values.decode(String.self, forKey: .type)
        action = try values.decode(String.self, forKey: .action)
        time = try values.decode(Int.self, forKey: .time)
        if let metaData = try? values.decodeIfPresent(Data.self, forKey: .meta) {
            meta = try? (JSONSerialization.jsonObject(with: metaData, options: .allowFragments) as! any Encodable)
        } else {
            meta = nil
        }
    }

    // MARK: Encodable

    func encode(to encoder: Encoder) throws {
        var baseContainer = encoder.container(keyedBy: CodingKeys.self)
        try baseContainer.encode(id, forKey: .id)

        try baseContainer.encode(type, forKey: .type)
        try baseContainer.encode(action, forKey: .action)
        try baseContainer.encode(time, forKey: .time)
        if let metaData = meta {
            try baseContainer.encode(metaData, forKey: .meta)
        }
    }
}
