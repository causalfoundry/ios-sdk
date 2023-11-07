//
//  SubmitEnrolmentEventObject.swift
//
//
//  Created by khushbu on 04/11/23.
//
import Foundation

internal struct SubmitEnrolmentEventObject: Codable {
    var patientId: String
    var siteId: String
    var action: String
    var patientStatusList: [PatientStatusItem]
    var diagnosisValuesList: [DiagnosisItem]
    var diagnosisResultsList: [DiagnosisItem]
    var treatmentPlanList: [TreatmentPlanItem]
    var meta: Encodable?
    
    enum CodingKeys: String, CodingKey {
        case patientId = "patient_id"
        case siteId = "site_id"
        case action
        case patientStatusList = "patient_status_list"
        case diagnosisValuesList = "diagnosis_values_list"
        case diagnosisResultsList = "diagnosis_results_list"
        case treatmentPlanList = "treatment_plan_list"
        case meta
    }
    
    
    init(patientId: String, siteId: String, action: String, patientStatusList: [PatientStatusItem], diagnosisValuesList: [DiagnosisItem], diagnosisResultsList: [DiagnosisItem], treatmentPlanList: [TreatmentPlanItem], meta: Encodable? = nil) {
        self.patientId = patientId
        self.siteId = siteId
        self.action = action
        self.patientStatusList = patientStatusList
        self.diagnosisValuesList = diagnosisValuesList
        self.diagnosisResultsList = diagnosisResultsList
        self.treatmentPlanList = treatmentPlanList
        self.meta = meta
    }
    // Encoding to JSON
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(patientId, forKey: .patientId)
        try container.encode(siteId, forKey: .siteId)
        try container.encode(action, forKey: .action)
        try container.encode(patientStatusList, forKey: .patientStatusList)
        try container.encode(diagnosisValuesList, forKey: .diagnosisValuesList)
        try container.encode(diagnosisResultsList, forKey: .diagnosisResultsList)
        try container.encode(treatmentPlanList, forKey: .treatmentPlanList)
        if let metaData = meta {
            try container.encode(metaData, forKey: .meta)
        }
        
    }
    
//    // Decoding from JSON
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        patientId = try container.decode(String.self, forKey: .patientId)
        siteId = try container.decode(String.self, forKey: .siteId)
        action = try container.decode(String.self, forKey: .action)
        patientStatusList = try container.decode([PatientStatusItem].self, forKey: .patientStatusList)
        diagnosisValuesList = try container.decode([DiagnosisItem].self, forKey: .diagnosisValuesList)
        diagnosisResultsList = try container.decode([DiagnosisItem].self, forKey: .diagnosisResultsList)
        treatmentPlanList = try container.decode([TreatmentPlanItem].self, forKey: .treatmentPlanList)

        if let metaData = try container.decodeIfPresent(Data.self, forKey: .meta) {
            meta = try? (JSONSerialization.jsonObject(with: metaData, options: .allowFragments) as! any Encodable)
        } else {
            meta = nil
        }
    }
}
