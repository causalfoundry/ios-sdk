//
//  SubmitAssessmentEventObject.swift
//
//
//  Created by khushbu on 03/11/23.
//

import Foundation

import Foundation

struct SubmitAssessmentEventObject: Codable {
    let patientId: String
    let siteId: String
    let category: String?
    let type: String?
    let referredForAssessment: Bool
    let medicationAdherence: MedicationAdherenceObject?
    let vitalsList: [DiagnosisItem]?
    var diagnosisQuestionnaireList: [DiagnosisQuestionnaireObject]?
    var diagnosisValuesList: [DiagnosisItem]?
    var diagnosisResultsList: [DiagnosisItem]?
    var diagnosisSymptomsList: [DiagnosisSymptomItem]?
    var pregnancyDetails: PregnancyDetailObject?
    
    let meta: Encodable?

    enum CodingKeys: String, CodingKey {
        case patientId = "patient_id"
        case siteId = "site_id"
        case category
        case type
        case medicationAdherence = "medication_adherence"
        case vitalsList = "vitals_list"
        case diagnosisQuestionnaireList = "diagnosis_questionnaire_list"
        case diagnosisValuesList = "diagnosis_values_list"
        case diagnosisResultsList = "diagnosis_results_list"
        case diagnosisSymptomsList = "diagnosis_symptoms_list"
        case pregnancyDetails = "pregnancy_details"
        case referredForAssessment = "referred_for_assessment"
        case meta
    }

    init(patientId: String, siteId: String, category: String? = "", type: String? = "", medicationAdherence: MedicationAdherenceObject? = nil, vitalsList: [DiagnosisItem]? = [], diagnosisQuestionnaireList: [DiagnosisQuestionnaireObject]? = [], diagnosisValuesList: [DiagnosisItem]? = [], diagnosisResultsList: [DiagnosisItem]? = [], diagnosisSymptomsList: [DiagnosisSymptomItem]? = [], pregnancyDetails: PregnancyDetailObject? = nil, referredForAssessment: Bool, meta: Encodable?) {
        self.patientId = patientId
        self.siteId = siteId
        self.category = category
        self.type = type
        self.medicationAdherence = medicationAdherence
        self.vitalsList = vitalsList
        self.diagnosisQuestionnaireList = diagnosisQuestionnaireList
        self.diagnosisValuesList = diagnosisValuesList
        self.diagnosisResultsList = diagnosisResultsList
        self.diagnosisSymptomsList = diagnosisSymptomsList
        self.referredForAssessment = referredForAssessment
        self.pregnancyDetails = pregnancyDetails
        self.meta = meta
    }

    // Encoding to JSON
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(patientId, forKey: .patientId)
        try container.encode(siteId, forKey: .siteId)
        try container.encodeIfPresent(category, forKey: .category)
        try container.encodeIfPresent(type, forKey: .type)
        try container.encodeIfPresent(medicationAdherence, forKey: .medicationAdherence)
        try container.encodeIfPresent(vitalsList, forKey: .vitalsList)
        try container.encodeIfPresent(diagnosisQuestionnaireList, forKey: .diagnosisQuestionnaireList)
        try container.encodeIfPresent(diagnosisValuesList, forKey: .diagnosisValuesList)
        try container.encodeIfPresent(diagnosisResultsList, forKey: .diagnosisResultsList)
        try container.encodeIfPresent(diagnosisSymptomsList, forKey: .diagnosisSymptomsList)
        try container.encodeIfPresent(pregnancyDetails, forKey: .pregnancyDetails)
        try container.encode(referredForAssessment, forKey: .referredForAssessment)
        if let metaData = meta {
            try container.encode(metaData, forKey: .meta)
        }
    }

    // Decoding from JSON
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        patientId = try container.decode(String.self, forKey: .patientId)
        siteId = try container.decode(String.self, forKey: .siteId)
        category = try container.decodeIfPresent(String.self, forKey: .category)
        type = try container.decodeIfPresent(String.self, forKey: .type)
        medicationAdherence = try container.decodeIfPresent(MedicationAdherenceObject.self, forKey: .medicationAdherence)
        vitalsList = try container.decodeIfPresent([DiagnosisItem].self, forKey: .vitalsList)
        diagnosisQuestionnaireList = try container.decodeIfPresent([DiagnosisQuestionnaireObject].self, forKey: .diagnosisQuestionnaireList)
        diagnosisValuesList = try container.decodeIfPresent([DiagnosisItem].self, forKey: .diagnosisValuesList)
        diagnosisResultsList = try container.decodeIfPresent([DiagnosisItem].self, forKey: .diagnosisResultsList)
        diagnosisSymptomsList = try container.decodeIfPresent([DiagnosisSymptomItem].self, forKey: .diagnosisSymptomsList)
        referredForAssessment = try container.decode(Bool.self, forKey: .referredForAssessment)
        pregnancyDetails = try container.decodeIfPresent(PregnancyDetailObject.self, forKey: .pregnancyDetails)
        if let metaData = try container.decodeIfPresent(Data.self, forKey: .meta) {
            meta = try? (JSONSerialization.jsonObject(with: metaData, options: .allowFragments) as! any Encodable)
        } else {
            meta = nil
        }
    }
}
