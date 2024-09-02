//
//  TreatmentPlanItem.swift
//
//
//  Created by khushbu on 04/11/23.
//

import Foundation

public struct TreatmentPlanItem: Codable {
    var followupList: [ScheduleItem]
    var prescriptionList: [PrescriptionItem]
    var investigationList: [InvestigationItem]

    enum CodingKeys: String, CodingKey {
        case followupList = "followup_list"
        case prescriptionList = "prescription_list"
        case investigationList = "investigation_list"
    }

    public init(followupList: [ScheduleItem], prescriptionList: [PrescriptionItem], investigationList: [InvestigationItem]) {
        self.followupList = followupList
        self.prescriptionList = prescriptionList
        self.investigationList = investigationList
    }

    // Encoding to JSON
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(followupList, forKey: .followupList)
        try container.encode(prescriptionList, forKey: .prescriptionList)
        try container.encode(investigationList, forKey: .investigationList)
    }

    // Decoding from JSON
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        followupList = try container.decode([ScheduleItem].self, forKey: .followupList)
        prescriptionList = try container.decode([PrescriptionItem].self, forKey: .prescriptionList)
        investigationList = try container.decode([InvestigationItem].self, forKey: .investigationList)
    }
}
