//
//  File.swift
//  
//
//  Created by MOIZ HASSAN KHAN on 30/8/24.
//

import Foundation


public struct PatientEventObject: Codable {
    var patientId: String
    var siteId: String
    var action: String
    var isFromGho: Bool
    var category: String
    var type: String
    var subType: String
    var biometricList: [DiagnosisItem]
    var pregnancyDetails: PregnancyDetailObject?
    var registrationDate: Int64?
    var meta: Encodable?

    public enum CodingKeys: String, CodingKey {
        case patientId = "patient_id"
        case siteId = "site_id"
        case action = "action"
        case isFromGho = "is_from_gho"
        case category = "category"
        case type = "type"
        case subType = "sub_type"
        case biometricList = "biometric_list"
        case pregnancyDetails = "pregnancy_details"
        case registrationDate = "registration_date"
        case meta
    }

    public init(patientId: String, siteId: String, action: HcwItemAction, isFromGho: Bool, category: HcwSiteCategory, type: PatientType, subType: String, biometricList: [DiagnosisItem], pregnancyDetails: PregnancyDetailObject? = nil, registrationDate: Int64? = nil, meta: Encodable? = nil) {
        self.patientId = patientId
        self.siteId = siteId
        self.action = action.rawValue
        self.isFromGho = isFromGho
        self.category = category.rawValue
        self.type = type.rawValue
        self.subType = subType
        self.biometricList = biometricList
        self.pregnancyDetails = pregnancyDetails
        self.registrationDate = registrationDate
        self.meta = meta
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        patientId = try container.decode(String.self, forKey: .patientId)
        siteId = try container.decode(String.self, forKey: .siteId)
        action = try container.decode(String.self, forKey: .action)
        isFromGho = try container.decode(Bool.self, forKey: .isFromGho)
        category = try container.decode(String.self, forKey: .category)
        type = try container.decode(String.self, forKey: .type)
        subType = try container.decode(String.self, forKey: .subType)
        biometricList = try container.decode([DiagnosisItem].self, forKey: .biometricList)
        pregnancyDetails = try container.decodeIfPresent(PregnancyDetailObject.self, forKey: .pregnancyDetails)
        registrationDate = try container.decodeIfPresent(Int64.self, forKey: .registrationDate)
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
        try container.encode(isFromGho, forKey: .isFromGho)
        try container.encode(category, forKey: .category)
        try container.encode(type, forKey: .type)
        try container.encode(subType, forKey: .subType)
        try container.encode(biometricList, forKey: .biometricList)
        try container.encodeIfPresent(pregnancyDetails, forKey: .pregnancyDetails)
        try container.encodeIfPresent(registrationDate, forKey: .registrationDate)
        if let metaData = meta {
            try container.encode(metaData, forKey: .meta)
        }
    }
}

