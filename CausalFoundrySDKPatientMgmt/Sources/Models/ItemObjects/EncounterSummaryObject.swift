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
    var prevDiagnosisStatusList: [DiagnosisStatusItem] = []
    var diagnosisStatusList: [DiagnosisStatusItem]
    var prevTreatmentPlan: TreatmentPlanItem?
    var treatmentPlan: TreatmentPlanItem?
    var mainComplaintsList: [String] = []
    var diagnosticElements: DiagnosticElementObject?
    var pregnancyDetails: PregnancyDetailObject?
    var counselingList: [CounselingPlanItem]?
    var immunizationList: [ImmunizationItem]?
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
        case prevDiagnosisStatusList = "prev_diagnosis_status_list"
        case diagnosisStatusList = "diagnosis_status_list"
        case prevTreatmentPlan = "prev_treatment_plan"
        case treatmentPlan = "treatment_plan"
        case mainComplaintsList = "main_complaints_list"
        case diagnosticElements = "diagnostic_elements"
        case pregnancyDetails = "pregnancy_details"
        case counselingList = "counseling_list"
        case immunizationList = "immunization_list"
        case subType = "sub_type"
        case remarks = "remarks"
        case isFollowupId = "is_followup_id"
        case isReferralId = "is_referral_id"
        case hasFollowup = "has_followup"
        case hasReferral = "has_referral"
        case meta
    }

    public init(encounterId: String, appointmentId: String, encounterTime: Int64, hcwIdList: [String], prevDiagnosisStatusList: [DiagnosisStatusItem] = [], diagnosisStatusList: [DiagnosisStatusItem] = [], prevTreatmentPlan: TreatmentPlanItem? = nil, treatmentPlan: TreatmentPlanItem? = nil, mainComplaintsList: [String] = [], diagnosticElements: DiagnosticElementObject? = nil, pregnancyDetails: PregnancyDetailObject? = nil, counselingList: [CounselingPlanItem] = [], immunizationList: [ImmunizationItem] = [], remarks: String? = "", isFollowupId: String? = "", isReferralId: String? = "", hasFollowup: Bool? = nil, hasReferral: Bool? = nil, meta: Encodable? = nil ) {
        self.encounterId = encounterId
        self.appointmentId = appointmentId
        self.encounterTime = encounterTime
        self.hcwIdList = hcwIdList
        self.prevDiagnosisStatusList = prevDiagnosisStatusList
        self.diagnosisStatusList = diagnosisStatusList
        self.prevTreatmentPlan = prevTreatmentPlan
        self.treatmentPlan = treatmentPlan
        self.mainComplaintsList = mainComplaintsList
        self.diagnosticElements = diagnosticElements
        self.pregnancyDetails = pregnancyDetails
        self.counselingList = counselingList
        self.immunizationList = immunizationList
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
        prevDiagnosisStatusList = try container.decode([DiagnosisStatusItem].self, forKey: .prevDiagnosisStatusList)
        diagnosisStatusList = try container.decode([DiagnosisStatusItem].self, forKey: .diagnosisStatusList)
        prevTreatmentPlan = try container.decodeIfPresent(TreatmentPlanItem.self, forKey: .prevTreatmentPlan)
        treatmentPlan = try container.decodeIfPresent(TreatmentPlanItem.self, forKey: .treatmentPlan)
        mainComplaintsList = try container.decode([String].self, forKey: .mainComplaintsList)
        diagnosticElements = try container.decodeIfPresent(DiagnosticElementObject.self, forKey: .diagnosticElements)
        pregnancyDetails = try container.decodeIfPresent(PregnancyDetailObject.self, forKey: .pregnancyDetails)
        counselingList = try container.decodeIfPresent([CounselingPlanItem].self, forKey: .counselingList)
        immunizationList = try container.decodeIfPresent([ImmunizationItem].self, forKey: .immunizationList)
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
        try container.encode(prevDiagnosisStatusList, forKey: .prevDiagnosisStatusList)
        try container.encode(diagnosisStatusList, forKey: .diagnosisStatusList)
        try container.encodeIfPresent(prevTreatmentPlan, forKey: .prevTreatmentPlan)
        try container.encodeIfPresent(treatmentPlan, forKey: .treatmentPlan)
        try container.encode(mainComplaintsList, forKey: .mainComplaintsList)
        try container.encodeIfPresent(diagnosticElements, forKey: .diagnosticElements)
        try container.encodeIfPresent(pregnancyDetails, forKey: .pregnancyDetails)
        try container.encodeIfPresent(counselingList, forKey: .counselingList)
        try container.encodeIfPresent(immunizationList, forKey: .immunizationList)
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

