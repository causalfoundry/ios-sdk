//
//  File.swift
//  
//
//  Created by MOIZ HASSAN KHAN on 30/8/24.
//

import Foundation

public struct AppointmentUpdateItem: Codable {
    var appointmentId: String
    var reason: String
    var prevTime: Int64

    public enum CodingKeys: String, CodingKey {
        case appointmentId = "id"
        case reason = "reason"
        case prevTime = "prev_time"
    }

    public init(appointmentId: String, reason: String, prevTime: Int64) {
        self.appointmentId = appointmentId
        self.reason = reason
        self.prevTime = prevTime
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        appointmentId = try container.decode(String.self, forKey: .appointmentId)
        reason = try container.decode(String.self, forKey: .reason)
        prevTime = try container.decode(Int64.self, forKey: .prevTime)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(appointmentId, forKey: .appointmentId)
        try container.encode(reason, forKey: .reason)
        try container.encode(prevTime, forKey: .prevTime)
    }
}

