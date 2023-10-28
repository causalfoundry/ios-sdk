//
//  EventDataObject.swift
//  
//
//  Created by khushbu on 21/09/23.
//

import Foundation


// MARK: - EventDataObject
//struct EventDataObject: Codable,ModelData {
//    var block : String?
//    var props : Any?
//    var type : String?
//    var ol : Bool?
//    var ts : String?
//    
//    enum CodingKeys: String, CodingKey {
//        case block = "block"
//        case props = "props"
//        case type = "type"
//        case ol = "ol"
//        case ts = "ts"
//    }
//    
//    init(block: String?, props: Any?, type: String?, ol: Bool?, ts: String?) {
//        self.block = block
//        self.props = props
//        self.type = type
//        self.ol = ol
//        self.ts = ts
//    }
//    
//    
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        block = try values.decodeIfPresent(String.self, forKey: .block)
//        if let decodeAppobject =  try values.decodeIfPresent(AppObject.self, forKey: .props) {
//            props = decodeAppobject
//        }else if let decodeIndentityObject = try values.decodeIfPresent(IdentifyObject.self, forKey: .props) {
//            props = decodeIndentityObject
//        }else if let decodePropsObject = try values.decodeIfPresent(Props.self, forKey: .props) {
//            props = decodePropsObject
//        }else if let decodeSearchObject = try values.decodeIfPresent(SearchObject.self, forKey: .props) {
//            props = decodeSearchObject
//        }else if let decodeSearchObject = try values.decodeIfPresent(ChwModelObject.self, forKey: .props) {
//            props = decodeSearchObject
//        }else if let decodeSearchObject = try values.decodeIfPresent(InvestigationEventObject.self, forKey: .props) {
//            props = decodeSearchObject
//        }else if let decodeLifeStypePlanObject = try values.decodeIfPresent(LifestylePlanItem.self, forKey: .props) {
//            props = decodeLifeStypePlanObject
//        }else {
//            props = nil
//        }
//        type = try values.decodeIfPresent(String.self, forKey: .type)
//        ol = try values.decodeIfPresent(Bool.self, forKey: .ol)
//        ts = try values.decodeIfPresent(String.self, forKey: .ts)
//        
//        
//        
//        
//    }
//    
//    // MARK: Encodable
//    func encode(to encoder: Encoder) throws {
//        var baseContainer = encoder.container(keyedBy: CodingKeys.self)
//        try baseContainer.encode(self.block, forKey: .block)
//        
//        try baseContainer.encode(self.type, forKey: .type)
//        try baseContainer.encode(self.ol, forKey: .ol)
//        try baseContainer.encode(self.ts, forKey: .ts)
//        
//        let dataEncoder = baseContainer.superEncoder(forKey: .props)
//        
//        // Use the Encoder directly:
//        if let appObjetTypeData = self.props as? AppObject {
//            try (appObjetTypeData).encode(to: dataEncoder)
//        }else if let identityTypeData = self.props as? IdentifyObject {
//            try (identityTypeData).encode(to: dataEncoder)
//        }else if let propsTypeData = self.props as? Props {
//            try (propsTypeData).encode(to: dataEncoder)
//        }else if let pageObjectTypeData = self.props as? PageObject {
//            try (pageObjectTypeData).encode(to: dataEncoder)
//        }else if let mediaObjectTypeData = self.props as? MediaObject {
//            try (mediaObjectTypeData).encode(to: dataEncoder)
//        }else if let rateObjectTypeData = self.props as? RateObject {
//            try (rateObjectTypeData).encode(to: dataEncoder)
//        }else if let searchObjectTypeData = self.props as? SearchObject {
//            try (searchObjectTypeData).encode(to: dataEncoder)
//        }else if let CHWObjectTypeData = self.props as? ChwModelObject {
//            try (CHWObjectTypeData).encode(to: dataEncoder)
//        }else if let investigationDatabjectTypeData = self.props as? InvestigationEventObject {
//            try (investigationDatabjectTypeData).encode(to: dataEncoder)
//        }else if let lifeStylePlanDatabjectTypeData = self.props as? LifestylePlanItem {
//            try (lifeStylePlanDatabjectTypeData).encode(to: dataEncoder)
//        }else if let lifeStylePlanItemDatabjectTypeData = self.props as? LifestyleEventObject {
//            try (lifeStylePlanItemDatabjectTypeData).encode(to: dataEncoder)
//        }
//        
//    }
//}
//// MARK: EventDataObject convenience initializers and mutators
//
//extension EventDataObject {
//    init(data: Data) throws {
//        self = try newJSONDecoder().decode(EventDataObject.self, from: data)
//    }
//    
//    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
//        guard let data = json.data(using: encoding) else {
//            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
//        }
//        try self.init(data: data)
//    }
//    
//    init(fromURL url: URL) throws {
//        try self.init(data: try Data(contentsOf: url))
//    }
// 
//    func jsonData() throws -> Data {
//        return try newJSONEncoder().encode(self)
//    }
//    
//    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
//        return String(data: try self.jsonData(), encoding: encoding)
//    }
//    
//    
//    public mutating func decode(to decoder: Decoder)throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        block = try values.decodeIfPresent(String.self, forKey: .block)
//        if let decodeAppobject =  try values.decodeIfPresent(AppObject.self, forKey: .props) {
//            props = decodeAppobject
//        }else if let decodeIndentityObject = try values.decodeIfPresent(IdentifyObject.self, forKey: .props) {
//            props = decodeIndentityObject
//        }else if let decodePropsObject = try values.decodeIfPresent(Props.self, forKey: .props) {
//            props = decodePropsObject
//        }else if let decodePageObject = try values.decodeIfPresent(PageObject.self, forKey: .props) {
//            props = decodePageObject
//        }else if let decodeMediaObject = try values.decodeIfPresent(MediaObject.self, forKey: .props) {
//            props = decodeMediaObject
//        }else if let decodeRateObject = try values.decodeIfPresent(RateObject.self, forKey: .props) {
//            props = decodeRateObject
//        }else if let decodeRateObject = try values.decodeIfPresent(RateObject.self, forKey: .props) {
//            props = decodeRateObject
//        }else {
//            props = nil
//        }
//        type = try values.decodeIfPresent(String.self, forKey: .type)
//        ol = try values.decodeIfPresent(Bool.self, forKey: .ol)
//        ts = try values.decodeIfPresent(String.self, forKey: .ts)
//        
//    }
//    
//    
//}


struct EventDataObject: Codable {
    var content_block: String
    var online: Bool
    var ts: String
    var event_type: String
    var event_properties: Any?
    
    enum CodingKeys: String, CodingKey {
        case content_block = "block"
        case online = "ol"
        case ts
        case event_type = "type"
        case event_properties = "props"
    }
    
    init(content_block: String, online: Bool, ts: String, event_type: String, event_properties: Any? = nil) {
        self.content_block = content_block
        self.online = online
        self.ts = ts
        self.event_type = event_type
        self.event_properties = event_properties
    }
    

        
        
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(content_block, forKey: .content_block)
        try container.encode(online, forKey: .online)
        try container.encode(ts, forKey: .ts)
        try container.encode(event_type, forKey: .event_type)
        
        if let properties = event_properties {
            if let propertiesData = try? JSONSerialization.data(withJSONObject: properties) {
                try container.encode(propertiesData, forKey: .event_properties)
            }
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        content_block = try container.decode(String.self, forKey: .content_block)
        online = try container.decode(Bool.self, forKey: .online)
        ts = try container.decode(String.self, forKey: .ts)
        event_type = try container.decode(String.self, forKey: .event_type)
        
        if let propertiesData = try container.decodeIfPresent(Data.self, forKey: .event_properties) {
            event_properties = try? JSONSerialization.jsonObject(with: propertiesData, options: .allowFragments)
        } else {
            event_properties = nil
        }
    }
}






// Define a protocol that requires conformance to Codable
protocol ModelData: Codable {}

// Create a struct that can hold any model data
struct AnyModelData<T: ModelData>: Codable {
    var model: T
}



