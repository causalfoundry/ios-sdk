//
//  TreatmentPlanEventObject.swift
//
//
//  Created by khushbu on 07/11/23.
//

import Foundation

struct TreatmentPlanEventObject: Codable {
    var patientId: String
    var siteId: String
    var treatmentPlanId: String
    var treatmentPlanList: [TreatmentPlanItem]
    var meta: Encodable?

    // CodingKeys to specify custom keys if needed
    enum CodingKeys: String, CodingKey {
        case patientId = "patient_id"
        case siteId = "site_id"
        case treatmentPlanId = "id"
        case treatmentPlanList = "treatment_plan_list"
        case meta
    }

    // Initializer for decoding
    init(
        patientId: String,
        siteId: String,
        treatmentPlanId: String,
        treatmentPlanList: [TreatmentPlanItem],
        meta: Encodable?
    ) {
        self.patientId = patientId
        self.siteId = siteId
        self.treatmentPlanId = treatmentPlanId
        self.treatmentPlanList = treatmentPlanList
        self.meta = meta
    }

    // Encoding function
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(patientId, forKey: .patientId)
        try container.encode(siteId, forKey: .siteId)
        try container.encode(treatmentPlanId, forKey: .treatmentPlanId)
        try container.encode(treatmentPlanList, forKey: .treatmentPlanList)
        if let metaData = meta {
            try container.encode(metaData, forKey: .meta)
        }
    }

    // Decoding initializer
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        patientId = try container.decode(String.self, forKey: .patientId)
        siteId = try container.decode(String.self, forKey: .siteId)
        treatmentPlanId = try container.decode(String.self, forKey: .treatmentPlanId)
        treatmentPlanList = try container.decode([TreatmentPlanItem].self, forKey: .treatmentPlanList)
        if let metaData = try container.decodeIfPresent(Data.self, forKey: .meta) {
            meta = try? (JSONSerialization.jsonObject(with: metaData, options: .allowFragments) as! any Encodable)
        } else {
            meta = nil
        }
    }
}
