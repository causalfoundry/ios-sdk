//
//  File.swift
//  
//
//  Created by MOIZ HASSAN KHAN on 30/8/24.
//

import Foundation

public struct AppointmentItem: Codable {
    var appointmentId: String
    var hcwId: String
    var category: String
    var status: String
    var appointmentDateTime: Int64
    var isTimeSensitive: Bool
    var typeList: [String]
    var subTypeList: [String]
    var update: AppointmentUpdateItem?
    var missed: AppointmentMissedItem?

    public enum CodingKeys: String, CodingKey {
        case appointmentId = "id"
        case hcwId = "hcw_id"
        case category = "category"
        case status = "status"
        case appointmentDateTime = "time"
        case isTimeSensitive = "is_time_sensitive"
        case typeList = "type_list"
        case subTypeList = "sub_type_list"
        case update = "update"
        case missed = "missed"
    }

    public init(appointmentId: String, hcwId: String, category: HcwSiteCategory, status: AppointmentStatus, appointmentDateTime: Int64, isTimeSensitive: Bool = true, typeList: [String], subTypeList: [String], update: AppointmentUpdateItem? = nil, missed: AppointmentMissedItem? = nil) {
        self.appointmentId = appointmentId
        self.hcwId = hcwId
        self.category = category.rawValue
        self.status = status.rawValue
        self.appointmentDateTime = appointmentDateTime
        self.isTimeSensitive = isTimeSensitive
        self.typeList = typeList
        self.subTypeList = subTypeList
        self.update = update
        self.missed = missed
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        appointmentId = try container.decode(String.self, forKey: .appointmentId)
        hcwId = try container.decode(String.self, forKey: .hcwId)
        category = try container.decode(String.self, forKey: .category)
        status = try container.decode(String.self, forKey: .status)
        appointmentDateTime = try container.decode(Int64.self, forKey: .appointmentDateTime)
        isTimeSensitive = try container.decode(Bool.self, forKey: .isTimeSensitive)
        typeList = try container.decode([String].self, forKey: .typeList)
        subTypeList = try container.decode([String].self, forKey: .subTypeList)
        update = try container.decodeIfPresent(AppointmentUpdateItem.self, forKey: .update)
        missed = try container.decodeIfPresent(AppointmentMissedItem.self, forKey: .missed)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(appointmentId, forKey: .appointmentId)
        try container.encode(hcwId, forKey: .hcwId)
        try container.encode(category, forKey: .category)
        try container.encode(status, forKey: .status)
        try container.encode(appointmentDateTime, forKey: .appointmentDateTime)
        try container.encode(isTimeSensitive, forKey: .isTimeSensitive)
        try container.encode(subTypeList, forKey: .subTypeList)
        try container.encodeIfPresent(update, forKey: .update)
        try container.encodeIfPresent(missed, forKey: .missed)
    }
}

