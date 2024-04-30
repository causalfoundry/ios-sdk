//
//  SubmitEnrolmentEventObject.swift
//
//
//  Created by khushbu on 04/11/23.
//
import Foundation

struct SubmitEnrolmentEventObject: Codable {
    var patientId: String
    var siteId: String
    var action: String
    var isFromGho: Bool
    let vitalsList: [DiagnosisItem]?
    var diagnosisValuesList: [DiagnosisItem]?
    var diagnosisResultsList: [DiagnosisItem]?
    var patientStatusList: [PatientStatusItem]?
    var diagnosisQuestionnaireList: [DiagnosisQuestionnaireObject]?
    var pregnancyDetails: PregnancyDetailObject?
    var treatmentPlanList: [TreatmentPlanItem]?
    var meta: Encodable?

    enum CodingKeys: String, CodingKey {
        case patientId = "patient_id"
        case siteId = "site_id"
        case action
        case isFromGho = "is_from_gho"
        case vitalsList = "vitals_list"
        case diagnosisValuesList = "diagnosis_values_list"
        case diagnosisResultsList = "diagnosis_results_list"
        case patientStatusList = "patient_status_list"
        case diagnosisQuestionnaireList = "diagnosis_questionnaire_list"
        case pregnancyDetails = "pregnancy_details"
        case treatmentPlanList = "treatment_plan_list"
        case meta
    }

    init(patientId: String, siteId: String, action: String, isFromGho: Bool, vitalsList: [DiagnosisItem]? = [], diagnosisValuesList: [DiagnosisItem]? = [], diagnosisResultsList: [DiagnosisItem]? = [], patientStatusList: [PatientStatusItem]? = [], diagnosisQuestionnaireList: [DiagnosisQuestionnaireObject]? = [], pregnancyDetails: PregnancyDetailObject? = nil, treatmentPlanList: [TreatmentPlanItem]? = [], meta: Encodable? = nil) {
        self.patientId = patientId
        self.siteId = siteId
        self.action = action
        self.isFromGho = isFromGho
        self.vitalsList = vitalsList
        self.patientStatusList = patientStatusList
        self.diagnosisValuesList = diagnosisValuesList
        self.diagnosisResultsList = diagnosisResultsList
        self.diagnosisQuestionnaireList = diagnosisQuestionnaireList
        self.pregnancyDetails = pregnancyDetails
        self.treatmentPlanList = treatmentPlanList
        self.meta = meta
    }

    // Encoding to JSON
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(patientId, forKey: .patientId)
        try container.encode(siteId, forKey: .siteId)
        try container.encode(action, forKey: .action)
        try container.encode(isFromGho, forKey: .isFromGho)
        try container.encodeIfPresent(vitalsList, forKey: .vitalsList)
        try container.encodeIfPresent(diagnosisValuesList, forKey: .diagnosisValuesList)
        try container.encodeIfPresent(diagnosisResultsList, forKey: .diagnosisResultsList)
        try container.encodeIfPresent(patientStatusList, forKey: .patientStatusList)
        try container.encodeIfPresent(diagnosisQuestionnaireList, forKey: .diagnosisQuestionnaireList)
        try container.encodeIfPresent(pregnancyDetails, forKey: .pregnancyDetails)
        try container.encodeIfPresent(treatmentPlanList, forKey: .treatmentPlanList)
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
        isFromGho = try container.decode(Bool.self, forKey: .isFromGho)
        vitalsList = try container.decodeIfPresent([DiagnosisItem].self, forKey: .vitalsList)
        diagnosisValuesList = try container.decodeIfPresent([DiagnosisItem].self, forKey: .diagnosisValuesList)
        diagnosisResultsList = try container.decodeIfPresent([DiagnosisItem].self, forKey: .diagnosisResultsList)
        patientStatusList = try container.decodeIfPresent([PatientStatusItem].self, forKey: .patientStatusList)
        diagnosisQuestionnaireList = try container.decodeIfPresent([DiagnosisQuestionnaireObject].self, forKey: .diagnosisQuestionnaireList)
        pregnancyDetails = try container.decodeIfPresent(PregnancyDetailObject.self, forKey: .pregnancyDetails)
        treatmentPlanList = try container.decodeIfPresent([TreatmentPlanItem].self, forKey: .treatmentPlanList)
        if let metaData = try container.decodeIfPresent(Data.self, forKey: .meta) {
            meta = try? (JSONSerialization.jsonObject(with: metaData, options: .allowFragments) as! any Encodable)
        } else {
            meta = nil
        }
    }
}
