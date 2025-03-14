//
//  ModuleObject.swift
//
//
//  Created by moizhassankh on 04/01/24.
//
import Foundation

public struct ModuleObject: Codable {
    var id: String = ""
    var progress: Int = 0
    var action: String = ""
    var meta: Encodable?

    private enum CodingKeys: String, CodingKey {
        case id
        case progress
        case action
        case meta
    }

    public init(id: String, progress: Int, action: ModuleLogAction, meta: Encodable? = nil) {
        self.id = id
        self.progress = progress
        self.action = action.rawValue
        self.meta = meta
    }

    // Encoding method
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(progress, forKey: .progress)
        try container.encode(action, forKey: .action)
        if let metaData = meta {
            try container.encodeIfPresent(metaData, forKey: .meta)
        }
    }

    //    // Decoding method
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        progress = try container.decode(Int.self, forKey: .progress)
        action = try container.decode(String.self, forKey: .action)
        if let metaData = try? container.decodeIfPresent(Data.self, forKey: .meta) {
            meta = try? (JSONSerialization.jsonObject(with: metaData, options: .allowFragments) as! any Encodable)
        } else {
            meta = nil
        }
    }
}
