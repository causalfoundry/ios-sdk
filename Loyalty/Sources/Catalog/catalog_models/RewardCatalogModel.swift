//
//  RewardCatalogModel.swift
//
//
//  Created by khushbu on 07/11/23.
//

import Foundation

public struct RewardCatalogModel: Codable {
    let name: String
    let description: String
    let type: String
    let requiredPoints: Float
    let creationDate: Int64
    let expiryDate: Int64
    let organizationId: String
    let organizationName: String

    enum CodingKeys: String, CodingKey {
        case name
        case description
        case type
        case requiredPoints = "required_points"
        case creationDate = "creation_date"
        case expiryDate = "expiry_date"
        case organizationId = "organization_id"
        case organizationName = "organization_name"
    }

    public init(name: String, description: String, type: String, requiredPoints: Float, creationDate: Int64, expiryDate: Int64, organizationId: String, organizationName: String) {
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
        name = try container.decode(String.self, forKey: .name)
        description = try container.decode(String.self, forKey: .description)
        type = try container.decode(String.self, forKey: .type)
        requiredPoints = try container.decode(Float.self, forKey: .requiredPoints)
        creationDate = try container.decode(Int64.self, forKey: .creationDate)
        expiryDate = try container.decode(Int64.self, forKey: .expiryDate)
        organizationId = try container.decode(String.self, forKey: .organizationId)
        organizationName = try container.decode(String.self, forKey: .organizationName)
    }
}
