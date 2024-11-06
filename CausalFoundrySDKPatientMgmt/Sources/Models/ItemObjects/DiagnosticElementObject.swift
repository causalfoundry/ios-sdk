//
//  File.swift
//  
//
//  Created by MOIZ HASSAN KHAN on 30/8/24.
//

import Foundation

public struct DiagnosticElementObject: Codable {
    var id: String
    var investigationList: [InvestigationItem] = []
    var biometricList: [DiagnosisItem] = []
    var signSymptomList: [DiagnosisSymptomItem] = []
    var treatmentAdherenceList: [TreatmentAdherenceItem] = []
    var healthQuestionnaireList: [DiagnosisQuestionnaireObject] = []

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case investigationList = "investigation_list"
        case biometricList = "biometric_list"
        case signSymptomList = "sign_symptom_list"
        case treatmentAdherenceList = "treatment_adherence_list"
        case healthQuestionnaireList = "health_questionnaire_list"

    }

    public init(id: String, investigationList: [InvestigationItem] = [], biometricList : [DiagnosisItem] = [], signSymptomList : [DiagnosisSymptomItem] = [], treatmentAdherenceList : [TreatmentAdherenceItem] = [], healthQuestionnaireList : [DiagnosisQuestionnaireObject] = []) {
        self.id = id
        self.investigationList = investigationList
        self.biometricList = biometricList
        self.signSymptomList = signSymptomList
        self.treatmentAdherenceList = treatmentAdherenceList
        self.healthQuestionnaireList = healthQuestionnaireList
    }

    // Encoding to JSON
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(investigationList, forKey: .investigationList)
        try container.encode(biometricList, forKey: .biometricList)
        try container.encode(signSymptomList, forKey: .signSymptomList)
        try container.encode(treatmentAdherenceList, forKey: .treatmentAdherenceList)
        try container.encode(healthQuestionnaireList, forKey: .healthQuestionnaireList)
    }

    // Decoding from JSON
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        investigationList = try container.decode([InvestigationItem].self, forKey: .investigationList)
        biometricList = try container.decode([DiagnosisItem].self, forKey: .biometricList)
        signSymptomList = try container.decode([DiagnosisSymptomItem].self, forKey: .signSymptomList)
        treatmentAdherenceList = try container.decode([TreatmentAdherenceItem].self, forKey: .treatmentAdherenceList)
        healthQuestionnaireList = try container.decode([DiagnosisQuestionnaireObject].self, forKey: .healthQuestionnaireList)
    }
}

