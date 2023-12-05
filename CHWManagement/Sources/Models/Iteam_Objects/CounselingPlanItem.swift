//
//  CounselingPlanItem.swift
//
//
//  Created by khushbu on 21/11/23.
//

import Foundation

import Foundation

public struct CounselingPlanItem: Codable {
    var name: String
    var action: String
    var clinicianNotes: String?
    var assessmentRemarks: String?
    var counselorNotes: String?
    var referralDate: Int64?
    var assessmentDate: Int64?
    var referredBy: String?
    var assessedBy: String?
    var remarks: String?

    enum CodingKeys: String, CodingKey {
        case name
        case action
        case clinicianNotes = "clinician_notes"
        case assessmentRemarks = "assessment_remarks"
        case counselorNotes = "counselor_notes"
        case referralDate = "referral_date"
        case assessmentDate = "assessment_date"
        case referredBy = "referred_by"
        case assessedBy = "assessed_by"
        case remarks
    }

    public init(name: String, action: String, clinicianNotes: String? = nil, assessmentRemarks: String? = nil, counselorNotes: String? = nil, referralDate: Int64? = nil, assessmentDate: Int64? = nil, referredBy: String? = nil, assessedBy: String? = nil, remarks: String? = nil) {
        self.name = name
        self.action = action
        self.clinicianNotes = clinicianNotes
        self.assessmentRemarks = assessmentRemarks
        self.counselorNotes = counselorNotes
        self.referralDate = referralDate
        self.assessmentDate = assessmentDate
        self.referredBy = referredBy
        self.assessedBy = assessedBy
        self.remarks = remarks
    }

    // MARK: - Codable Methods

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        name = try container.decode(String.self, forKey: .name)
        action = try container.decode(String.self, forKey: .action)
        clinicianNotes = try container.decodeIfPresent(String.self, forKey: .clinicianNotes)
        assessmentRemarks = try container.decodeIfPresent(String.self, forKey: .assessmentRemarks)
        counselorNotes = try container.decodeIfPresent(String.self, forKey: .counselorNotes)
        referralDate = try container.decodeIfPresent(Int64.self, forKey: .referralDate)
        assessmentDate = try container.decodeIfPresent(Int64.self, forKey: .assessmentDate)
        referredBy = try container.decodeIfPresent(String.self, forKey: .referredBy)
        assessedBy = try container.decodeIfPresent(String.self, forKey: .assessedBy)
        remarks = try container.decodeIfPresent(String.self, forKey: .remarks)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(name, forKey: .name)
        try container.encode(action, forKey: .action)
        try container.encodeIfPresent(clinicianNotes, forKey: .clinicianNotes)
        try container.encodeIfPresent(assessmentRemarks, forKey: .assessmentRemarks)
        try container.encodeIfPresent(counselorNotes, forKey: .counselorNotes)
        try container.encodeIfPresent(referralDate, forKey: .referralDate)
        try container.encodeIfPresent(assessmentDate, forKey: .assessmentDate)
        try container.encodeIfPresent(referredBy, forKey: .referredBy)
        try container.encodeIfPresent(assessedBy, forKey: .assessedBy)
        try container.encodeIfPresent(remarks, forKey: .remarks)
    }
}
