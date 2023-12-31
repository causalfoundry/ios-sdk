//
//  InvestigationEventObject.swift
//
//
//  Created by khushbu on 26/10/23.
//

import Foundation

public struct InvestigationEventObject: Codable {
    var patientId: String
    var siteId: String
    var investigationId: String
    var prescribedTestsList: [InvestigationItem]
    var meta: Any?

    public enum CodingKeys: String, CodingKey {
        case patientId = "patient_id"
        case siteId = "site_id"
        case investigationId = "id"
        case prescribedTestsList = "prescribed_tests_list"
        case meta
    }

    public init(patientId: String, siteId: String, investigationId: String, prescribedTestsList: [InvestigationItem], meta: Any? = nil) {
        self.patientId = patientId
        self.siteId = siteId
        self.investigationId = investigationId
        self.prescribedTestsList = prescribedTestsList
        self.meta = meta
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        patientId = try container.decode(String.self, forKey: .patientId)
        siteId = try container.decode(String.self, forKey: .siteId)
        investigationId = try container.decode(String.self, forKey: .investigationId)
        prescribedTestsList = try container.decode([InvestigationItem].self, forKey: .prescribedTestsList)
        if let intValue = try? container.decodeIfPresent(Int.self, forKey: .meta) {
            meta = intValue
        } else if let doubleValue = try? container.decodeIfPresent(Double.self, forKey: .meta) {
            meta = doubleValue
        } else if let stringValue = try? container.decodeIfPresent(String.self, forKey: .meta) {
            meta = stringValue
        } else if let boolValue = try? container.decodeIfPresent(Bool.self, forKey: .meta) {
            meta = boolValue
        } else if let dateValue = try? container.decodeIfPresent(Date.self, forKey: .meta) {
            meta = dateValue
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(patientId, forKey: .patientId)
        try container.encode(siteId, forKey: .siteId)
        try container.encode(investigationId, forKey: .investigationId)
        try container.encode(prescribedTestsList, forKey: .prescribedTestsList)
        if let meta = meta {
            if let intValue = meta as? Int {
                try container.encode(intValue, forKey: .meta)
            } else if let doubleValue = meta as? Double {
                try container.encode(doubleValue, forKey: .meta)
            } else if let stringValue = meta as? String {
                try container.encode(stringValue, forKey: .meta)
            } else if let boolValue = meta as? Bool {
                try container.encode(boolValue, forKey: .meta)
            } else if let dateValue = meta as? Date {
                try container.encode(dateValue, forKey: .meta)
            }
        }
    }
}
