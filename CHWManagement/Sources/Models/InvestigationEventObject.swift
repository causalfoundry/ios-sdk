//
//  InvestigationEventObject.swift
//
//
//  Created by khushbu on 26/10/23.
//

import Foundation


import Foundation

struct InvestigationEventObject: Codable {
    var patientId: String
    var siteId: String
    var investigationId: String
    var prescribedTestsList: [InvestigationItem]
    var meta: MetaValue?

    enum CodingKeys: String, CodingKey {
        case patientId = "patient_id"
        case siteId = "site_id"
        case investigationId = "id"
        case prescribedTestsList = "prescribed_tests_list"
        case meta = "meta"
    }

    init(patientId: String, siteId: String, investigationId: String, prescribedTestsList: [InvestigationItem], meta: MetaValue? = nil) {
        self.patientId = patientId
        self.siteId = siteId
        self.investigationId = investigationId
        self.prescribedTestsList = prescribedTestsList
        self.meta = meta
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        patientId = try container.decode(String.self, forKey: .patientId)
        siteId = try container.decode(String.self, forKey: .siteId)
        investigationId = try container.decode(String.self, forKey: .investigationId)
        prescribedTestsList = try container.decode([InvestigationItem].self, forKey: .prescribedTestsList)
        meta = try container.decodeIfPresent(MetaValue.self, forKey: .meta)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(patientId, forKey: .patientId)
        try container.encode(siteId, forKey: .siteId)
        try container.encode(investigationId, forKey: .investigationId)
        try container.encode(prescribedTestsList, forKey: .prescribedTestsList)
        try container.encode(meta, forKey: .meta)
    }
}
