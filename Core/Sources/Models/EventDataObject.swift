//
//  EventDataObject.swift
//  
//
//  Created by khushbu on 21/09/23.
//

import Foundation


// MARK: - EventDataObject
struct EventDataObject: Codable {
    var block : String?
    var props : Any?
    var type : String?
    var ol : Bool?
    var ts : String?
    
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
        }else if let decodeIndentityObject = try values.decodeIfPresent(IdentifyObject.self, forKey: .props) {
            props = decodeIndentityObject
        }else if let decodePropsObject = try values.decodeIfPresent(Props.self, forKey: .props) {
            props = decodePropsObject
        }else {
            props = nil
        }
        type = try values.decodeIfPresent(String.self, forKey: .type)
        ol = try values.decodeIfPresent(Bool.self, forKey: .ol)
        ts = try values.decodeIfPresent(String.self, forKey: .ts)
    }
    
    // MARK: Encodable
    func encode(to encoder: Encoder) throws {
        var baseContainer = encoder.container(keyedBy: CodingKeys.self)
        try baseContainer.encode(self.block, forKey: .block)
       // try baseContainer.encode(self.props, forKey: .props)
        try baseContainer.encode(self.type, forKey: .type)
        try baseContainer.encode(self.ol, forKey: .ol)
        try baseContainer.encode(self.ts, forKey: .ts)
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
    
    
    public mutating func decode(to decoder: Decoder)throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        block = try values.decodeIfPresent(String.self, forKey: .block)
        if let decodeAppobject =  try values.decodeIfPresent(AppObject.self, forKey: .props) {
            props = decodeAppobject
        }else if let decodeIndentityObject = try values.decodeIfPresent(IdentifyObject.self, forKey: .props) {
            props = decodeIndentityObject
        }else if let decodePropsObject = try values.decodeIfPresent(Props.self, forKey: .props) {
            props = decodePropsObject
        }else {
            props = nil
        }
        type = try values.decodeIfPresent(String.self, forKey: .type)
        ol = try values.decodeIfPresent(Bool.self, forKey: .ol)
        ts = try values.decodeIfPresent(String.self, forKey: .ts)
        
    }
    
    
}

