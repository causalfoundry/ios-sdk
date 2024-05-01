//
//  SubmitScreeningEventObject.swift
//
//
//  Created by khushbu on 07/11/23.
//

import Foundation

public struct SubmitScreeningEventObject: Codable {
    var patientId: String
    var siteId: String
    var vitalsList: [DiagnosisItem]?
    var diagnosisSymptomsList: [DiagnosisSymptomItem]?
    var diagnosisQuestionnaireList: [DiagnosisQuestionnaireObject]?
    var diagnosisValuesList: [DiagnosisItem]?
    var diagnosisResultsList: [DiagnosisItem]?
    var pregnancyDetails: PregnancyDetailObject?
    var category: String
    var type: String
    var referredForAssessment: Bool
    var meta: Encodable?

    enum CodingKeys: String, CodingKey {
        case patientId = "patient_id"
        case siteId = "site_id"
        case vitalsList = "vitals_list"
        case diagnosisSymptomsList = "diagnosis_symptoms_list"
        case diagnosisQuestionnaireList = "diagnosis_questionnaire_list"
        case diagnosisValuesList = "diagnosis_values_list"
        case diagnosisResultsList = "diagnosis_results_list"
        case pregnancyDetails = "pregnancy_details"
        case category
        case type
        case referredForAssessment = "referred_for_assessment"
        case meta
    }

    public init(patientId: String, siteId: String, vitalsList: [DiagnosisItem]? = [], diagnosisSymptomsList: [DiagnosisSymptomItem]? = [], diagnosisQuestionnaireList: [DiagnosisQuestionnaireObject]? = [], diagnosisValuesList: [DiagnosisItem]? = [], diagnosisResultsList: [DiagnosisItem]? = [], pregnancyDetails: PregnancyDetailObject? = nil, category: String, type: String, referredForAssessment: Bool, meta: Encodable? = nil) {
        self.patientId = patientId
        self.siteId = siteId
        self.vitalsList = vitalsList
        self.diagnosisSymptomsList = diagnosisSymptomsList
        self.diagnosisQuestionnaireList = diagnosisQuestionnaireList
        self.diagnosisValuesList = diagnosisValuesList
        self.diagnosisResultsList = diagnosisResultsList
        self.pregnancyDetails = pregnancyDetails
        self.category = category
        self.type = type
        self.referredForAssessment = referredForAssessment
        self.meta = meta
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        patientId = try container.decode(String.self, forKey: .patientId)
        siteId = try container.decode(String.self, forKey: .siteId)
        vitalsList = try container.decodeIfPresent([DiagnosisItem].self, forKey: .vitalsList)
        diagnosisSymptomsList = try container.decodeIfPresent([DiagnosisSymptomItem].self, forKey: .diagnosisSymptomsList)
        diagnosisQuestionnaireList = try container.decodeIfPresent([DiagnosisQuestionnaireObject].self, forKey: .diagnosisQuestionnaireList)
        diagnosisValuesList = try container.decodeIfPresent([DiagnosisItem].self, forKey: .diagnosisValuesList)
        diagnosisResultsList = try container.decodeIfPresent([DiagnosisItem].self, forKey: .diagnosisResultsList)
        pregnancyDetails = try container.decodeIfPresent(PregnancyDetailObject.self, forKey: .pregnancyDetails)
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
        try container.encodeIfPresent(vitalsList, forKey: .vitalsList)
        try container.encodeIfPresent(diagnosisSymptomsList, forKey: .diagnosisSymptomsList)
        try container.encodeIfPresent(diagnosisQuestionnaireList, forKey: .diagnosisQuestionnaireList)
        try container.encodeIfPresent(diagnosisValuesList, forKey: .diagnosisValuesList)
        try container.encodeIfPresent(diagnosisResultsList, forKey: .diagnosisResultsList)
        try container.encodeIfPresent(pregnancyDetails, forKey: .pregnancyDetails)
        try container.encode(category, forKey: .category)
        try container.encode(type, forKey: .type)
        try container.encode(referredForAssessment, forKey: .referredForAssessment)
        if let metaData = meta {
            try container.encode(metaData, forKey: .meta)
        }
    }
}
