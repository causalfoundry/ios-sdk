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
    let medicationAdherence: String
    var diagnosisValuesList: [DiagnosisItem]
    var diagnosisResultsList: [DiagnosisItem]
    var diagnosisSymptomsList: [DiagnosisSymptomItem]
    let referredForAssessment: Bool
    let meta: Encodable?
    
    enum CodingKeys: String, CodingKey {
        case patientId = "patient_id"
        case siteId = "site_id"
        case medicationAdherence = "medication_adherence"
        case diagnosisValuesList = "diagnosis_values_list"
        case diagnosisResultsList = "diagnosis_results_list"
        case diagnosisSymptomsList = "diagnosis_symptoms_list"
        case referredForAssessment = "referred_for_assessment"
        case meta
    }
    
    
    init(patientId: String, siteId: String, medicationAdherence: String, diagnosisValuesList: [DiagnosisItem], diagnosisResultsList: [DiagnosisItem], diagnosisSymptomsList: [DiagnosisSymptomItem], referredForAssessment: Bool, meta: Encodable?) {
        self.patientId = patientId
        self.siteId = siteId
        self.medicationAdherence = medicationAdherence
        self.diagnosisValuesList = diagnosisValuesList
        self.diagnosisResultsList = diagnosisResultsList
        self.diagnosisSymptomsList = diagnosisSymptomsList
        self.referredForAssessment = referredForAssessment
        self.meta = meta
    }
    
    // Encoding to JSON
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(patientId, forKey: .patientId)
        try container.encode(siteId, forKey: .siteId)
        try container.encode(medicationAdherence, forKey: .medicationAdherence)
        try container.encode(diagnosisValuesList, forKey: .diagnosisValuesList)
        try container.encode(diagnosisResultsList, forKey: .diagnosisResultsList)
        try container.encode(diagnosisSymptomsList, forKey: .diagnosisSymptomsList)
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
        medicationAdherence = try container.decode(String.self, forKey: .medicationAdherence)
        diagnosisValuesList = try container.decode([DiagnosisItem].self, forKey: .diagnosisValuesList)
        diagnosisResultsList = try container.decode([DiagnosisItem].self, forKey: .diagnosisResultsList)
        diagnosisSymptomsList = try container.decode([DiagnosisSymptomItem].self, forKey: .diagnosisSymptomsList)
        referredForAssessment = try container.decode(Bool.self, forKey: .referredForAssessment)
        if let metaData = try container.decodeIfPresent(Data.self, forKey: .meta) {
            meta = try? (JSONSerialization.jsonObject(with: metaData, options: .allowFragments) as! any Encodable)
        } else {
            meta = nil
        }
        
    }
}
