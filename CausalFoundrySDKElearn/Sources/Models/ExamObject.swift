//
//  ExamObject.swift
//
//
//  Created by moizhassankhan on 04/01/24.
//
import Foundation

public struct ExamObject: Codable {
    var id: String
    var action: String
    var duration: Int?
    var score: Float?
    var isPassed: Bool?
    var meta: Encodable?

    enum CodingKeys: String, CodingKey {
        case id
        case action
        case duration
        case score
        case isPassed = "is_passed"
        case meta
    }

    init(id: String, action: String, duration: Int? = nil, score: Float? = nil, isPassed: Bool? = nil, meta: Encodable? = nil) {
        self.id = id
        self.action = action
        self.duration = duration
        self.score = score
        self.isPassed = isPassed
        self.meta = meta
    }

    // Encoding method
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(action, forKey: .action)
        try container.encodeIfPresent(duration, forKey: .duration)
        try container.encodeIfPresent(score, forKey: .score)
        try container.encodeIfPresent(isPassed, forKey: .isPassed)
        if let metaData = meta {
            try container.encode(metaData, forKey: .meta)
        }
    }

    // Decoding method
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        action = try container.decode(String.self, forKey: .action)
        duration = try container.decodeIfPresent(Int.self, forKey: .duration)
        score = try container.decodeIfPresent(Float.self, forKey: .score)
        isPassed = try container.decodeIfPresent(Bool.self, forKey: .isPassed)
        if let metaData = try? container.decodeIfPresent(Data.self, forKey: .meta) {
            meta = try? (JSONSerialization.jsonObject(with: metaData, options: .allowFragments) as! any Encodable)
        } else {
            meta = nil
        }
    }
}
