//
//  EventDataObject.swift
//
//
//  Created by khushbu on 21/09/23.
//

import Foundation

struct EventDataObject: Codable, Hashable {
    enum CodingKeys: String, CodingKey {
        case block
        case ol
        case ts
        case type
        case props
    }

    let block: String
    let ol: Bool
    let ts: String
    let type: String
    let props: [String: Any]?

    init<T: Codable>(block: String, ol: Bool, ts: Date, type: String, props: T) {
        self.block = block
        self.ol = ol
        self.ts = ISO8601DateFormatter().string(from: ts)
        self.type = type
        self.props = props.dictionary
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        block = try container.decode(String.self, forKey: .block)
        ol = try container.decode(Bool.self, forKey: .ol)
        ts = try container.decode(String.self, forKey: .ts)
        type = try container.decode(String.self, forKey: .type)
        props = try container.decodeIfPresent([String: Any].self, forKey: .props)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(block, forKey: .block)
        try container.encode(ol, forKey: .ol)
        try container.encode(ts, forKey: .ts)
        try container.encode(type, forKey: .type)
        try container.encodeIfPresent(props, forKey: .props)
    }
    
    // Computed property to check if `type` or `props` is nil or empty
    var isTypeOrPropsEmpty: Bool {
        return type.isEmpty || props?.isEmpty ?? true
    }
    
    // Hashable conformance with props inclusion
    func hash(into hasher: inout Hasher) {
        hasher.combine(block)
        hasher.combine(ol)
        hasher.combine(ts)
        hasher.combine(type)
        
        if let props = propsAsJSONData() {
            hasher.combine(props)
        }
    }

    static func == (lhs: EventDataObject, rhs: EventDataObject) -> Bool {
        return lhs.block == rhs.block &&
               lhs.ol == rhs.ol &&
               lhs.ts == rhs.ts &&
               lhs.type == rhs.type &&
               lhs.propsAsJSONData() == rhs.propsAsJSONData()
    }

    // Convert props dictionary to JSON data for accurate comparison
    private func propsAsJSONData() -> Data? {
        guard let props = props else { return nil }
        return try? JSONSerialization.data(withJSONObject: props, options: .sortedKeys)
    }

}
