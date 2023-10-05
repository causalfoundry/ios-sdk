//
//  EventDataObject.swift
//  
//
//  Created by khushbu on 21/09/23.
//

import Foundation



//struct JSONData: Codable {
//    var value:Any?
//    
//    public init(from decoder: Decoder) throws {
//        if let value = try? decoder.singleValueContainer() {
//              if value.decodeNil() {
//                self.value = nil
//              } else {
//                if let result = try? value.decode(AppObject.self) { self.value = result }
//                if let result = try? value.decode(IdentifyObject.self) { self.value = result }
//               }
//            }
//      }
//
//      public func encode(to encoder: Encoder) throws {
//      }
//    
//}
// MARK: - EventDataObject
struct EventDataObject: Codable {
    let block: String
    let props: Any?
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
        props: Any? = nil,
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
    
    public init(from decoder: Decoder) throws {
        if let value = try? decoder.singleValueContainer() {
            if value.decodeNil() {
                self.props = nil
            } else {
                if let result = try? value.decode(AppObject.self) { self.props = result }
                if let result = try? value.decode(IdentifyObject.self) { self.props = result }
            }
        }
    }
}

