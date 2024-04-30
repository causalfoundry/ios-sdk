//
//  MedicalReviewObject. 2.swift
//
//
//  Created by Moiz Hassan Khan on 30/04/24.
//

import Foundation

public struct MedicalReviewObject: Codable {
    let id: String?
    var diagnosisResultsList: [DiagnosisItem]?
    var patientStatusList: [PatientStatusItem]?
    var clinicalNotes: String?
    var reviewSummaryList: [MedicalReviewSummaryObject]?
    var nextMedicalReview: Int64?
    var pregnancyDetails: PregnancyDetailObject?
    var lifestyleAssessmentList: [DiagnosisQuestionItem]?
    var remarks: String?

    enum CodingKeys: String, CodingKey {
        case id
        case diagnosisResultsList = "diagnosis_results_list"
        case patientStatusList = "patient_status_list"
        case clinicalNotes = "clinical_notes"
        case reviewSummaryList = "review_summary_list"
        case nextMedicalReview = "next_medical_review"
        case pregnancyDetails = "pregnancyDetails"
        case lifestyleAssessmentList = "lifestyle_assessment_list"
        case remarks
    }

    public init(id: String, diagnosisResultsList: [DiagnosisItem] = [], patientStatusList: [PatientStatusItem] = [], clinicalNotes: String = "", reviewSummaryList: [MedicalReviewSummaryObject] = [], nextMedicalReview: Int64 = 0, pregnancyDetails: PregnancyDetailObject? = nil, lifestyleAssessmentList: [DiagnosisQuestionItem]? = [], remarks: String? = "") {
        self.id = id
        self.diagnosisResultsList = diagnosisResultsList
        self.patientStatusList = patientStatusList
        self.clinicalNotes = clinicalNotes
        self.reviewSummaryList = reviewSummaryList
        self.nextMedicalReview = nextMedicalReview
        self.pregnancyDetails = pregnancyDetails
        self.lifestyleAssessmentList = lifestyleAssessmentList
        self.remarks = remarks
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        diagnosisResultsList = try container.decodeIfPresent([DiagnosisItem].self, forKey: .diagnosisResultsList)
        patientStatusList = try container.decodeIfPresent([PatientStatusItem].self, forKey: .patientStatusList)
        clinicalNotes = try container.decodeIfPresent(String.self, forKey: .clinicalNotes)
        reviewSummaryList = try container.decodeIfPresent([MedicalReviewSummaryObject].self, forKey: .reviewSummaryList)
        nextMedicalReview = try container.decodeIfPresent(Int64.self, forKey: .nextMedicalReview)
        pregnancyDetails = try container.decodeIfPresent(PregnancyDetailObject.self, forKey: .pregnancyDetails)
        lifestyleAssessmentList = try container.decodeIfPresent([DiagnosisQuestionItem].self, forKey: .lifestyleAssessmentList)
        remarks = try container.decodeIfPresent(String.self, forKey: .remarks)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encodeIfPresent(diagnosisResultsList, forKey: .diagnosisResultsList)
        try container.encodeIfPresent(patientStatusList, forKey: .patientStatusList)
        try container.encodeIfPresent(clinicalNotes, forKey: .clinicalNotes)
        try container.encodeIfPresent(reviewSummaryList, forKey: .reviewSummaryList)
        try container.encodeIfPresent(nextMedicalReview, forKey: .nextMedicalReview)
        try container.encodeIfPresent(pregnancyDetails, forKey: .pregnancyDetails)
        try container.encodeIfPresent(lifestyleAssessmentList, forKey: .lifestyleAssessmentList)
        try container.encodeIfPresent(remarks, forKey: .remarks)
    }
}
