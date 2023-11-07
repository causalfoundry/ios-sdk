//
//  SubmitScreeningEventObject.swift
//
//
//  Created by khushbu on 07/11/23.
//

import Foundation


import Foundation

public struct SubmitScreeningEventObject: Codable {
    var patientId: String
    var siteId: String
    var diagnosisValuesList: [DiagnosisItem]
    var diagnosisResultsList: [DiagnosisItem]
    var category: String
    var type: String
    var referredForAssessment: Bool
    var meta: Encodable?
    
    enum CodingKeys: String, CodingKey {
        case patientId = "patient_id"
        case siteId = "site_id"
        case diagnosisValuesList = "diagnosis_values_list"
        case diagnosisResultsList = "diagnosis_results_list"
        case category
        case type
        case referredForAssessment = "referred_for_assessment"
        case meta
    }
    
    public init(patientId: String, siteId: String, diagnosisValuesList: [DiagnosisItem], diagnosisResultsList: [DiagnosisItem], category: String, type: String, referredForAssessment: Bool, meta: Encodable? = nil) {
        self.patientId = patientId
        self.siteId = siteId
        self.diagnosisValuesList = diagnosisValuesList
        self.diagnosisResultsList = diagnosisResultsList
        self.category = category
        self.type = type
        self.referredForAssessment = referredForAssessment
        self.meta = meta
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        patientId = try container.decode(String.self, forKey: .patientId)
        siteId = try container.decode(String.self, forKey: .siteId)
        diagnosisValuesList = try container.decode([DiagnosisItem].self, forKey: .diagnosisValuesList)
        diagnosisResultsList = try container.decode([DiagnosisItem].self, forKey: .diagnosisResultsList)
        category = try container.decode(String.self, forKey: .category)
        type = try container.decode(String.self, forKey: .type)
        referredForAssessment = try container.decode(Bool.self, forKey: .referredForAssessment)
        if let metaData = try container.decodeIfPresent(Data.self, forKey: .meta) {
            meta = try? (JSONSerialization.jsonObject(with: metaData, options: .allowFragments) as! any Encodable)
        } else {
            meta = nil
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(patientId, forKey: .patientId)
        try container.encode(siteId, forKey: .siteId)
        try container.encode(diagnosisValuesList, forKey: .diagnosisValuesList)
        try container.encode(diagnosisResultsList, forKey: .diagnosisResultsList)
        try container.encode(category, forKey: .category)
        try container.encode(type, forKey: .type)
        try container.encode(referredForAssessment, forKey: .referredForAssessment)
        if let metaData = meta {
            try container.encode(metaData, forKey: .meta)
        }
    }
}
