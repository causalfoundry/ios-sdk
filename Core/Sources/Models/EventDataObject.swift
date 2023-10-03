//
//  EventDataObject.swift
//  
//
//  Created by khushbu on 21/09/23.
//

import Foundation


// MARK: - EventDataObject
struct EventDataObject: Codable {
    let block: String
    let props: AppObject
    let type: String
    let ol: Bool
    let ts: String
}

// MARK: EventDataObject convenience initializers and mutators

extension EventDataObject {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(EventDataObject.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        block: String? = nil,
        props: AppObject? = nil,
        type: String? = nil,
        ol: Bool? = nil,
        ts: String? = nil
    ) -> EventDataObject {
        return EventDataObject(
            block: block ?? self.block,
            props: props ?? self.props,
            type: type ?? self.type,
            ol: ol ?? self.ol,
            ts: ts ?? self.ts
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

