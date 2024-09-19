//
//  File.swift
//  
//
//  Created by MOIZ HASSAN KHAN on 29/8/24.
//

import Foundation

public struct InternalIdentifyObject: Codable {
    var userId: String
    var action: String
    var blocked: BlockedObject?
    var meta: Encodable?

    public init(userId: String, action: String, blocked: BlockedObject? = nil, meta: Encodable? = nil) {
        self.userId = userId
        self.action = action
        self.blocked = blocked
        self.meta = meta
    }

    enum CodingKeys: String, CodingKey {
        case userId
        case action
        case blocked
        case meta
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        userId = try values.decode(String.self, forKey: .userId)
        action = try values.decode(String.self, forKey: .action)
        blocked = try values.decodeIfPresent(BlockedObject.self, forKey: .blocked)
        if let meatData = try? values.decodeIfPresent(Data.self, forKey: .meta) {
            meta = try? (JSONSerialization.jsonObject(with: meatData, options: .allowFragments) as! any Encodable)
        } else {
            meta = nil
        }
    }

    // MARK: Encodable

    public func encode(to encoder: Encoder) throws {
        var baseContainer = encoder.container(keyedBy: CodingKeys.self)
        try baseContainer.encode(userId, forKey: .userId)
        try baseContainer.encode(action, forKey: .action)
        try baseContainer.encode(blocked, forKey: .blocked)
        if let meta_Data = meta {
            try baseContainer.encode(meta_Data, forKey: .meta)
        }
    }
}

extension InternalIdentifyObject {
    func toIdentifyObject() -> IdentifyObject {
        return IdentifyObject(
            userId: self.userId,
            action: self.action,
            blocked: self.blocked,
            meta: self.meta
        )
    }
}
