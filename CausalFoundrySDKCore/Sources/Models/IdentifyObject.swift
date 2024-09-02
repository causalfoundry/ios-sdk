//
//  IdentityObject.swift
//
//
//  Created by moizhassankh on 29/08/24.
//

import Foundation

public struct IdentifyObject: Codable {
    var userId: String?
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
        case action
        case blocked
        case meta
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
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
        try baseContainer.encode(action, forKey: .action)
        try baseContainer.encode(blocked, forKey: .blocked)
        if let meta_Data = meta {
            try baseContainer.encode(meta_Data, forKey: .meta)
        }
    }
}



///////////

public struct BlockedObject: Codable {
    var reason: String
    var remarks: String?

    public init(reason: String, remarks: String? = nil) {
        self.reason = reason
        self.remarks = remarks
    }

    enum CodingKeys: String, CodingKey {
        case reason
        case remarks
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        reason = try values.decode(String.self, forKey: .reason)
        remarks = try values.decodeIfPresent(String.self, forKey: .remarks)
    }

    // MARK: Encodable

    public func encode(to encoder: Encoder) throws {
        var baseContainer = encoder.container(keyedBy: CodingKeys.self)
        try baseContainer.encode(reason, forKey: .reason)
        try baseContainer.encode(remarks, forKey: .remarks)
    }
}

