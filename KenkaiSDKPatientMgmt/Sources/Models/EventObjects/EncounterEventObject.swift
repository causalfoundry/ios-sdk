//
//  File.swift
//  
//
//  Created by MOIZ HASSAN KHAN on 30/8/24.
//

import Foundation

public struct EncounterEventObject: Codable {
    var encounterId: String
    var type: String
    var subType: String
    var patientId: String
    var siteId: String
    var action: String
    var category: String
    var location: String
    var hcwIdList: [String]?
    var appointmentId: String?
    var encounterTime: String?
    var risk: String?
    var meta: Encodable?

    enum CodingKeys: String, CodingKey {
        case encounterId = "id"
        case patientId = "patient_id"
        case siteId = "site_id"
        case action
        case category
        case type
        case hcwIdList = "hcw_id_list"
        case subType = "sub_type"
        case location = "location"
        case appointmentId = "appointment_id"
        case encounterTime = "encounter_time"
        case risk = "risk"
        case meta
    }

    public init(encounterId: String, patientId: String, siteId: String, action: HcwItemAction, category: HcwSiteCategory, type: EncounterType, subType: DiagnosisType, location: String, hcwIdList: [String]? = nil, appointmentId: String? = nil, encounterTime: String? = nil, risk: String? = nil, meta: Encodable? = nil ) {
        self.encounterId = encounterId
        self.patientId = patientId
        self.siteId = siteId
        self.action = action.rawValue
        self.category = category.rawValue
        self.type = type.rawValue
        self.subType = subType.rawValue
        self.location = location
        self.hcwIdList = hcwIdList
        self.appointmentId = appointmentId
        self.encounterTime = encounterTime
        self.risk = risk
        self.meta = meta
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        encounterId = try container.decode(String.self, forKey: .encounterId)
        patientId = try container.decode(String.self, forKey: .patientId)
        siteId = try container.decode(String.self, forKey: .siteId)
        action = try container.decode(String.self, forKey: .action)
        category = try container.decode(String.self, forKey: .category)
        type = try container.decode(String.self, forKey: .type)
        subType = try container.decode(String.self, forKey: .subType)
        location = try container.decode(String.self, forKey: .location)
        hcwIdList = try container.decodeIfPresent([String].self, forKey: .hcwIdList)
        appointmentId = try container.decodeIfPresent(String.self, forKey: .appointmentId)
        encounterTime = try container.decodeIfPresent(String.self, forKey: .encounterTime)
        risk = try container.decodeIfPresent(String.self, forKey: .risk)
        if let metaData = try? container.decodeIfPresent(Data.self, forKey: .meta) {
            meta = try? (JSONSerialization.jsonObject(with: metaData, options: .allowFragments) as! any Encodable)
        } else {
            meta = nil
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(encounterId, forKey: .encounterId)
        try container.encode(patientId, forKey: .patientId)
        try container.encode(siteId, forKey: .siteId)
        try container.encode(action, forKey: .action)
        try container.encode(category, forKey: .category)
        try container.encode(type, forKey: .type)
        try container.encode(subType, forKey: .subType)
        try container.encode(location, forKey: .location)
        try container.encodeIfPresent(hcwIdList, forKey: .hcwIdList)
        try container.encodeIfPresent(appointmentId, forKey: .appointmentId)
        try container.encodeIfPresent(encounterTime, forKey: .encounterTime)
        try container.encodeIfPresent(risk, forKey: .risk)
        if let metaData = meta {
            try container.encodeIfPresent(metaData, forKey: .meta)
        }
    }
}

