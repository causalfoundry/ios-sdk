//
//  File.swift
//  
//
//  Created by MOIZ HASSAN KHAN on 30/8/24.
//

import Foundation

public struct EncounterSummaryObject: Codable {
    var encounterId: String
    var appointmentId: String
    var encounterTime: Int64
    var hcwIdList: [String]
    var prevDiagnosisStatus: [DiagnosisStatusItem] = []
    var diagnosisStatus: [DiagnosisStatusItem]
    var prevTreatmentPlan: [TreatmentPlanItem]?
    var treatmentPlan: [TreatmentPlanItem]?
    var mainComplaints: [String] = []
    var diagnosticElements: [DiagnosticElementObject]?
    var pregnancyDetails: PregnancyDetailObject?
    var counselingList: [CounselingPlanItem]?
    var remarks: String?
    var isFollowupId: String?
    var isReferralId: String?
    var hasFollowup: Bool?
    var hasReferral: Bool?
    var meta: Encodable?

    enum CodingKeys: String, CodingKey {
        case encounterId = "id"
        case appointmentId = "appointment_id"
        case encounterTime = "encounter_time"
        case hcwIdList = "hcw_id_list"
        case prevDiagnosisStatus = "prev_diagnosis_status"
        case diagnosisStatus = "diagnosis_status"
        case prevTreatmentPlan = "prev_treatment_plan"
        case treatmentPlan = "treatment_plan"
        case mainComplaints = "main_complaints"
        case diagnosticElements = "diagnostic_elements"
        case pregnancyDetails = "pregnancy_details"
        case counselingList = "counseling_list"
        case subType = "sub_type"
        case remarks = "remarks"
        case isFollowupId = "is_followup_id"
        case isReferralId = "is_referral_id"
        case hasFollowup = "has_followup"
        case hasReferral = "has_referral"
        case meta
    }

    public init(encounterId: String, appointmentId: String, encounterTime: Int64, hcwIdList: [String], prevDiagnosisStatus: [DiagnosisStatusItem] = [], diagnosisStatus: [DiagnosisStatusItem] = [], prevTreatmentPlan: [TreatmentPlanItem]? = nil, treatmentPlan: [TreatmentPlanItem]? = nil, mainComplaints: [String] = [], diagnosticElements: [DiagnosticElementObject]? = nil, pregnancyDetails: PregnancyDetailObject? = nil, counselingList: [CounselingPlanItem] = [], remarks: String? = "", isFollowupId: String? = "", isReferralId: String? = "", hasFollowup: Bool? = nil, hasReferral: Bool? = nil, meta: Encodable? = nil ) {
        self.encounterId = encounterId
        self.appointmentId = appointmentId
        self.encounterTime = encounterTime
        self.hcwIdList = hcwIdList
        self.prevDiagnosisStatus = prevDiagnosisStatus
        self.diagnosisStatus = diagnosisStatus
        self.prevTreatmentPlan = prevTreatmentPlan
        self.treatmentPlan = treatmentPlan
        self.mainComplaints = mainComplaints
        self.diagnosticElements = diagnosticElements
        self.pregnancyDetails = pregnancyDetails
        self.counselingList = counselingList
        self.remarks = remarks
        self.isFollowupId = isFollowupId
        self.isReferralId = isReferralId
        self.hasFollowup = hasFollowup
        self.hasReferral = hasReferral
        self.meta = meta
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        encounterId = try container.decode(String.self, forKey: .encounterId)
        appointmentId = try container.decode(String.self, forKey: .appointmentId)
        encounterTime = try container.decode(Int64.self, forKey: .encounterTime)
        hcwIdList = try container.decode([String].self, forKey: .hcwIdList)
        prevDiagnosisStatus = try container.decode([DiagnosisStatusItem].self, forKey: .prevDiagnosisStatus)
        diagnosisStatus = try container.decode([DiagnosisStatusItem].self, forKey: .diagnosisStatus)
        prevTreatmentPlan = try container.decodeIfPresent([TreatmentPlanItem].self, forKey: .prevTreatmentPlan)
        treatmentPlan = try container.decodeIfPresent([TreatmentPlanItem].self, forKey: .treatmentPlan)
        mainComplaints = try container.decode([String].self, forKey: .mainComplaints)
        diagnosticElements = try container.decodeIfPresent([DiagnosticElementObject].self, forKey: .diagnosticElements)
        pregnancyDetails = try container.decodeIfPresent(PregnancyDetailObject.self, forKey: .pregnancyDetails)
        counselingList = try container.decodeIfPresent([CounselingPlanItem].self, forKey: .counselingList)
        remarks = try container.decodeIfPresent(String.self, forKey: .remarks)
        isFollowupId = try container.decodeIfPresent(String.self, forKey: .isFollowupId)
        isReferralId = try container.decodeIfPresent(String.self, forKey: .isReferralId)
        hasFollowup = try container.decodeIfPresent(Bool.self, forKey: .hasFollowup)
        hasReferral = try container.decodeIfPresent(Bool.self, forKey: .hasReferral)
        if let metaData = try? container.decodeIfPresent(Data.self, forKey: .meta) {
            meta = try? (JSONSerialization.jsonObject(with: metaData, options: .allowFragments) as! any Encodable)
        } else {
            meta = nil
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(encounterId, forKey: .encounterId)
        try container.encode(appointmentId, forKey: .appointmentId)
        try container.encode(encounterTime, forKey: .encounterTime)
        try container.encode(hcwIdList, forKey: .hcwIdList)
        try container.encode(prevDiagnosisStatus, forKey: .prevDiagnosisStatus)
        try container.encode(diagnosisStatus, forKey: .diagnosisStatus)
        try container.encodeIfPresent(prevTreatmentPlan, forKey: .prevTreatmentPlan)
        try container.encodeIfPresent(treatmentPlan, forKey: .treatmentPlan)
        try container.encode(mainComplaints, forKey: .mainComplaints)
        try container.encodeIfPresent(diagnosticElements, forKey: .diagnosticElements)
        try container.encodeIfPresent(pregnancyDetails, forKey: .pregnancyDetails)
        try container.encodeIfPresent(counselingList, forKey: .counselingList)
        try container.encodeIfPresent(remarks, forKey: .remarks)
        try container.encodeIfPresent(isFollowupId, forKey: .isFollowupId)
        try container.encodeIfPresent(isReferralId, forKey: .isReferralId)
        try container.encodeIfPresent(hasFollowup, forKey: .hasFollowup)
        try container.encodeIfPresent(hasReferral, forKey: .hasReferral)
        if let metaData = meta {
            try container.encode(metaData, forKey: .meta)
        }
    }
}

