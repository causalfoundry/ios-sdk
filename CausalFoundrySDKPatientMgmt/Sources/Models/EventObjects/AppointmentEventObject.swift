//
//  File.swift
//  
//
//  Created by MOIZ HASSAN KHAN on 30/8/24.
//

import Foundation

public struct AppointmentEventObject: Codable {
    var appointmentId: String
    var patientId: String
    var siteId: String
    var action: String
    var location: String
    var hcwIdList: [String]?
    var isTimeSensitive: Bool?
    var status: String
    var category: String
    var appointmentDateTime: String
    var type: String
    var subType: String?
    var updateReason: String?
    var followupId: String?
    var followUpType: String?
    var followupResponse: String?
    var meta: Encodable?

    enum CodingKeys: String, CodingKey {
        case appointmentId = "id"
        case patientId = "patient_id"
        case siteId = "site_id"
        case action = "action"
        case location = "location"
        case hcwIdList = "hcw_id_list"
        case isTimeSensitive = "is_time_sensitive"
        case status = "status"
        case category = "category"
        case type = "type"
        case subType = "sub_type"
        case updateReason = "update_reason"
        case appointmentDateTime = "time"
        case followupId = "followup_id"
        case followUpType = "followup_type"
        case followupResponse = "followup_response"
        case meta
    }

    public init(appointmentId: String, patientId: String, siteId: String, action: HcwItemAction, location: String, status: AppointmentStatus, category: String, appointmentDateTime: String, type: String, subType: String? = nil, hcwIdList: [String]? = nil, isTimeSensitive: Bool? = nil, updateReason: String? = nil, followupId: String? = nil, followUpType: String? = nil, followupResponse: String? = nil, meta: Encodable? = nil) {
        self.appointmentId = appointmentId
        self.patientId = patientId
        self.siteId = siteId
        self.action = action.rawValue
        self.location = location
        self.hcwIdList = hcwIdList
        self.isTimeSensitive = isTimeSensitive ?? true
        self.status = status.rawValue
        self.appointmentDateTime = appointmentDateTime
        self.category = category
        self.type = type
        self.subType = subType
        self.updateReason = updateReason
        self.followupId = followupId
        self.followUpType = followUpType
        self.followupResponse = followupResponse
    
        self.meta = meta
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        appointmentId = try container.decode(String.self, forKey: .appointmentId)
        patientId = try container.decode(String.self, forKey: .patientId)
        siteId = try container.decode(String.self, forKey: .siteId)
        action = try container.decode(String.self, forKey: .action)
        location = try container.decode(String.self, forKey: .location)
        status = try container.decode(String.self, forKey: .status)
        category = try container.decode(String.self, forKey: .category)
        appointmentDateTime = try container.decode(String.self, forKey: .appointmentDateTime)
        type = try container.decode(String.self, forKey: .type)
        subType = try container.decodeIfPresent(String.self, forKey: .subType)
        hcwIdList = try container.decodeIfPresent([String].self, forKey: .hcwIdList)
        isTimeSensitive = try container.decodeIfPresent(Bool.self, forKey: .isTimeSensitive)
        updateReason = try container.decodeIfPresent(String.self, forKey: .updateReason)
        followupId = try container.decodeIfPresent(String.self, forKey: .followupId)
        followUpType = try container.decodeIfPresent(String.self, forKey: .followUpType)
        followupResponse = try container.decodeIfPresent(String.self, forKey: .followupResponse)
        if let metaData = try container.decodeIfPresent(Data.self, forKey: .meta) {
            meta = try? (JSONSerialization.jsonObject(with: metaData, options: .allowFragments) as! any Encodable)
        } else {
            meta = nil
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(appointmentId, forKey: .appointmentId)
        try container.encode(patientId, forKey: .patientId)
        try container.encode(siteId, forKey: .siteId)
        try container.encode(action, forKey: .action)
        try container.encode(location, forKey: .location)
        try container.encode(status, forKey: .status)
        try container.encode(category, forKey: .category)
        try container.encode(appointmentDateTime, forKey: .appointmentDateTime)
        try container.encode(type, forKey: .type)
        try container.encodeIfPresent(subType, forKey: .subType)
        try container.encodeIfPresent(hcwIdList, forKey: .hcwIdList)
        try container.encodeIfPresent(isTimeSensitive, forKey: .isTimeSensitive)
        try container.encodeIfPresent(updateReason, forKey: .updateReason)
        try container.encodeIfPresent(followupId, forKey: .followupId)
        try container.encodeIfPresent(followUpType, forKey: .followUpType)
        try container.encodeIfPresent(followupResponse, forKey: .followupResponse)
        if let metaData = meta {
            try container.encode(metaData, forKey: .meta)
        }
    }
}
