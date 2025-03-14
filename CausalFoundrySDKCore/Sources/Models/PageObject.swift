//
//  PageObject.swift
//
//
//  Created by khushbu on 06/10/23.
//

import Foundation

public struct PageObject: Codable {
    var path: String
    var title: String
    var duration: Float
    var renderTime: Int
    var meta: Encodable?

    public init(path: String, title: String, duration: Float, renderTime: Int = 0, meta: Encodable? = nil) {
        self.path = path
        self.title = title
        self.duration = duration
        self.renderTime = renderTime
        self.meta = meta
    }

    enum CodingKeys: String, CodingKey {
        case path
        case title
        case duration
        case render_time
        case meta
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        path = try values.decode(String.self, forKey: .path)
        title = try values.decode(String.self, forKey: .title)
        duration = try values.decode(Float.self, forKey: .duration)
        renderTime = try values.decode(Int.self, forKey: .render_time)

        if let meatData = try? values.decodeIfPresent(Data.self, forKey: .meta) {
            meta = try? (JSONSerialization.jsonObject(with: meatData, options: .allowFragments) as! any Encodable)
        } else {
            meta = nil
        }
    }

    // MARK: Encodable

    public func encode(to encoder: Encoder) throws {
        var baseContainer = encoder.container(keyedBy: CodingKeys.self)
        try baseContainer.encode(path, forKey: .path)

        try baseContainer.encode(title, forKey: .title)
        try baseContainer.encode(duration, forKey: .duration)
        try baseContainer.encode(renderTime, forKey: .render_time)
        if let meta_Data = meta {
            try baseContainer.encodeIfPresent(meta_Data, forKey: .meta)
        }
    }
}
