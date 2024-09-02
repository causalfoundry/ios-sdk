//
//  File.swift
//  
//
//  Created by MOIZ HASSAN KHAN on 30/8/24.
//

import Foundation

public struct AppointmentMissedItem: Codable {
    var id: String
    var appointmentFollowUpType: String
    var followUptime: Int64
    var response: String

    public enum CodingKeys: String, CodingKey {
        case id = "id"
        case appointmentFollowUpType = "type"
        case followUptime = "time"
        case response = "response"
    }

    public init(id: String, appointmentFollowUpType: String, followUptime: Int64, response: String) {
        self.id = id
        self.appointmentFollowUpType = appointmentFollowUpType
        self.followUptime = followUptime
        self.response = response
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        appointmentFollowUpType = try container.decode(String.self, forKey: .appointmentFollowUpType)
        followUptime = try container.decode(Int64.self, forKey: .followUptime)
        response = try container.decode(String.self, forKey: .response)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(appointmentFollowUpType, forKey: .appointmentFollowUpType)
        try container.encode(followUptime, forKey: .followUptime)
        try container.encode(response, forKey: .response)
    }
}

