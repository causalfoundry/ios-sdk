//
//  File.swift
//  
//
//  Created by MOIZ HASSAN KHAN on 30/8/24.
//

import Foundation

public struct DiagnosisEventObject: Codable {
    var name: String
    var encounterId: String
    var patientId: String
    var type: String
    var subType: String?
    var category: String
    var siteId: String
    var action: String
    var location: String
    var value: String?
    var result: String?
    var meta: Encodable?

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case encounterId = "encounter_id"
        case patientId = "patient_id"
        case type = "type"
        case subType = "sub_type"
        case siteId = "site_id"
        case action = "action"
        case location = "location"
        case value = "value"
        case category = "category"
        case result = "result"
        case meta
    }

    public init(name: String, encounterId: String, patientId: String, siteId: String, action: HcwItemAction, location: String, category: String, type: String, subType: String? = nil, hcwIdList: [String]? = nil, value: String? = nil, result: String? = nil, meta: Encodable? = nil) {
        self.name = name
        self.encounterId = encounterId
        self.patientId = patientId
        self.siteId = siteId
        self.action = action.rawValue
        self.location = location
        self.value = value
        self.category = category
        self.type = type
        self.subType = subType
        self.result = result
        self.value = value
        self.meta = meta
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        encounterId = try container.decode(String.self, forKey: .encounterId)
        patientId = try container.decode(String.self, forKey: .patientId)
        siteId = try container.decode(String.self, forKey: .siteId)
        action = try container.decode(String.self, forKey: .action)
        location = try container.decode(String.self, forKey: .location)
        category = try container.decode(String.self, forKey: .category)
        type = try container.decode(String.self, forKey: .type)
        subType = try container.decodeIfPresent(String.self, forKey: .subType)
        result = try container.decodeIfPresent(String.self, forKey: .result)
        value = try container.decodeIfPresent(String.self, forKey: .value)
       
        if let metaData = try container.decodeIfPresent(Data.self, forKey: .meta) {
            meta = try? (JSONSerialization.jsonObject(with: metaData, options: .allowFragments) as! any Encodable)
        } else {
            meta = nil
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(encounterId, forKey: .encounterId)
        try container.encode(patientId, forKey: .patientId)
        try container.encode(siteId, forKey: .siteId)
        try container.encode(action, forKey: .action)
        try container.encode(location, forKey: .location)
        try container.encode(category, forKey: .category)
        try container.encode(type, forKey: .type)
        try container.encodeIfPresent(subType, forKey: .subType)
        try container.encodeIfPresent(result, forKey: .result)
        try container.encodeIfPresent(value, forKey: .value)
        
        if let metaData = meta {
            try container.encode(metaData, forKey: .meta)
        }
    }
}
