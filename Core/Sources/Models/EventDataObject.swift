//
//  EventDataObject.swift
//  
//
//  Created by khushbu on 21/09/23.
//

import Foundation


// MARK: - EventDataObject
struct EventDataObject: Codable {
    let block : String?
    let props : Any?
    let type : String?
    let ol : Bool?
    let ts : String?
    
    enum CodingKeys: String, CodingKey {

        case block = "block"
        case props = "props"
        case type = "type"
        case ol = "ol"
        case ts = "ts"
    }
    
    init(block: String?, props: Any?, type: String?, ol: Bool?, ts: String?) {
        self.block = block
        self.props = props
        self.type = type
        self.ol = ol
        self.ts = ts
    }


    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        block = try values.decodeIfPresent(String.self, forKey: .block)
        if let decodeAppobject =  try values.decodeIfPresent(AppObject.self, forKey: .props) {
            props = decodeAppobject
        }else if let  decodeIndentityObject = try values.decodeIfPresent(IdentifyObject.self, forKey: .props) {
            props = decodeIndentityObject
        }else {
            props = nil
        }
        type = try values.decodeIfPresent(String.self, forKey: .type)
        ol = try values.decodeIfPresent(Bool.self, forKey: .ol)
        ts = try values.decodeIfPresent(String.self, forKey: .ts)
    }

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
 
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
    
    
    public func encode(to encoder: Encoder) throws {
   
    }
}

