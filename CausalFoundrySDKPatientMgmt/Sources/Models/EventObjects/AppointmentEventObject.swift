//
//  File.swift
//  
//
//  Created by MOIZ HASSAN KHAN on 30/8/24.
//

import Foundation

public struct AppointmentEventObject: Codable {
    var patientId: String
    var siteId: String
    var action: String
    var appointment: AppointmentItem
    var meta: Encodable?

    enum CodingKeys: String, CodingKey {
        case patientId = "patient_id"
        case siteId = "site_id"
        case action = "action"
        case appointment = "appointment"
        case meta
    }

    public init(patientId: String, siteId: String, action: HcwItemAction, appointment: AppointmentItem, meta: Encodable? = nil) {
        self.patientId = patientId
        self.siteId = siteId
        self.action = action.rawValue
        self.appointment = appointment
        self.meta = meta
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        patientId = try container.decode(String.self, forKey: .patientId)
        siteId = try container.decode(String.self, forKey: .siteId)
        action = try container.decode(String.self, forKey: .action)
        appointment = try container.decode(AppointmentItem.self, forKey: .appointment)
        if let metaData = try container.decodeIfPresent(Data.self, forKey: .meta) {
            meta = try? (JSONSerialization.jsonObject(with: metaData, options: .allowFragments) as! any Encodable)
        } else {
            meta = nil
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(patientId, forKey: .patientId)
        try container.encode(siteId, forKey: .siteId)
        try container.encode(action, forKey: .action)
        try container.encode(appointment, forKey: .appointment)
        if let metaData = meta {
            try container.encode(metaData, forKey: .meta)
        }
    }
}
