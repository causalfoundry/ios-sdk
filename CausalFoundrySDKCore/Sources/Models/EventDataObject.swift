//
//  EventDataObject.swift
//
//
//  Created by khushbu on 21/09/23.
//

import Foundation

struct EventDataObject: Codable, Hashable {
    enum CodingKeys: String, CodingKey {
        case ol
        case ts
        case name
        case property
        case ctx
    }

    let ol: Bool
    let ts: String
    let name: String
    let property: String
    let ctx: [String: Any]?

    init<T: Codable>(ol: Bool, ts: Date, name: String, property: String, ctx: T) {
        self.ol = ol
        self.ts = ISO8601DateFormatter().string(from: ts)
        self.name = name
        self.property = property
        self.ctx = ctx.dictionary
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        ol = try container.decode(Bool.self, forKey: .ol)
        ts = try container.decode(String.self, forKey: .ts)
        name = try container.decode(String.self, forKey: .name)
        property = try container.decode(String.self, forKey: .property)
        ctx = try container.decodeIfPresent([String: Any].self, forKey: .ctx)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(ol, forKey: .ol)
        try container.encode(ts, forKey: .ts)
        try container.encode(name, forKey: .name)
        try container.encode(property, forKey: .property)
        try container.encodeIfPresent(ctx, forKey: .ctx)
    }
    
    // Computed property to check if `type` or `props` is nil or empty
    var isTypeOrPropsEmpty: Bool {
        return name.isEmpty
    }
    
    // Hashable conformance with props inclusion
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(ol)
        hasher.combine(ts)
        
        if let props = propsAsJSONData() {
            hasher.combine(props)
        }
    }

    static func == (lhs: EventDataObject, rhs: EventDataObject) -> Bool {
        return lhs.name == rhs.name &&
               lhs.ol == rhs.ol &&
               lhs.ts == rhs.ts &&
               lhs.property == rhs.property &&
               lhs.propsAsJSONData() == rhs.propsAsJSONData()
    }

    // Convert props dictionary to JSON data for accurate comparison
    private func propsAsJSONData() -> Data? {
        guard let props = ctx else { return nil }
        return try? JSONSerialization.data(withJSONObject: props, options: .sortedKeys)
    }

}
