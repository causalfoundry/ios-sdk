//
//  InternalRewardModel.swift
//
//
//  Created by khushbu on 07/11/23.
//

import Foundation

public struct InternalRewardModel: Codable {
    let id: String
    let name: String
    let description: String
    let type: String
    let requiredPoints: Float
    let creationDate: String
    let expiryDate: String
    let organizationId: String
    let organizationName: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case type
        case requiredPoints = "required_points"
        case creationDate = "creation_date"
        case expiryDate = "expiry_date"
        case organizationId = "organization_id"
        case organizationName = "organization_name"
    }

    public init(id: String, name: String, description: String, type: String, requiredPoints: Float, creationDate: String, expiryDate: String, organizationId: String, organizationName: String) {
        self.id = id
        self.name = name
        self.description = description
        self.type = type
        self.requiredPoints = requiredPoints
        self.creationDate = creationDate
        self.expiryDate = expiryDate
        self.organizationId = organizationId
        self.organizationName = organizationName
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(description, forKey: .description)
        try container.encode(type, forKey: .type)
        try container.encode(requiredPoints, forKey: .requiredPoints)
        try container.encode(creationDate, forKey: .creationDate)
        try container.encode(expiryDate, forKey: .expiryDate)
        try container.encode(organizationId, forKey: .organizationId)
        try container.encode(organizationName, forKey: .organizationName)
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        description = try container.decode(String.self, forKey: .description)
        type = try container.decode(String.self, forKey: .type)
        requiredPoints = try container.decode(Float.self, forKey: .requiredPoints)
        creationDate = try container.decode(String.self, forKey: .creationDate)
        expiryDate = try container.decode(String.self, forKey: .expiryDate)
        organizationId = try container.decode(String.self, forKey: .organizationId)
        organizationName = try container.decode(String.self, forKey: .organizationName)
    }
}
