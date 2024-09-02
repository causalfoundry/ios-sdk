//
//  File.swift
//  
//
//  Created by MOIZ HASSAN KHAN on 30/8/24.
//

import Foundation

public struct AppointmentEventObject: Codable {
    var action: String
    var appointment: AppointmentItem
    var meta: Encodable?

    enum CodingKeys: String, CodingKey {
        case action = "action"
        case appointment = "appointment"
        case meta
    }

    public init(action: String, appointment: AppointmentItem, meta: Encodable? = nil) {
        self.action = action
        self.appointment = appointment
        self.meta = meta
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
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
        try container.encode(action, forKey: .action)
        try container.encode(appointment, forKey: .appointment)
        if let metaData = meta {
            try container.encode(metaData, forKey: .meta)
        }
    }
}
