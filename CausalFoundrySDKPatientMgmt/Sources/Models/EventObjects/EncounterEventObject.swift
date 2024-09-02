//
//  File.swift
//  
//
//  Created by MOIZ HASSAN KHAN on 30/8/24.
//

import Foundation

public struct EncounterEventObject: Codable {
    var patientId: String
    var siteId: String
    var action: String
    var category: String
    var type: String
    var subType: String
    var encounterSummaryObject: EncounterSummaryObject
    var meta: Encodable?

    enum CodingKeys: String, CodingKey {
        case patientId = "id"
        case siteId = "site_id"
        case action
        case category
        case type
        case subType = "sub_type"
        case encounterSummaryObject = "encounter_summary"
        case meta
    }

    public init(patientId: String, siteId: String, action: String, category: String, type: String, subType: String, encounterSummaryObject: EncounterSummaryObject, meta: Encodable? = nil ) {
        self.patientId = patientId
        self.siteId = siteId
        self.action = action
        self.category = category
        self.type = type
        self.subType = subType
        self.encounterSummaryObject = encounterSummaryObject
        self.meta = meta
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        patientId = try container.decode(String.self, forKey: .patientId)
        siteId = try container.decode(String.self, forKey: .siteId)
        action = try container.decode(String.self, forKey: .action)
        category = try container.decode(String.self, forKey: .category)
        type = try container.decode(String.self, forKey: .type)
        subType = try container.decode(String.self, forKey: .subType)
        encounterSummaryObject = try container.decode(EncounterSummaryObject.self, forKey: .encounterSummaryObject)
        if let metaData = try? container.decodeIfPresent(Data.self, forKey: .meta) {
            meta = try? (JSONSerialization.jsonObject(with: metaData, options: .allowFragments) as! any Encodable)
        } else {
            meta = nil
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(patientId, forKey: .patientId)
        try container.encode(siteId, forKey: .siteId)
        try container.encode(action, forKey: .action)
        try container.encode(category, forKey: .category)
        try container.encode(type, forKey: .type)
        try container.encode(subType, forKey: .subType)
        try container.encode(encounterSummaryObject, forKey: .encounterSummaryObject)
        if let metaData = meta {
            try container.encode(metaData, forKey: .meta)
        }
    }
}

