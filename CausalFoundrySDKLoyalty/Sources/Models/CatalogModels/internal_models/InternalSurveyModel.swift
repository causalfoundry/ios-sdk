//
//  InternalSurveyModel.swift
//
//
//  Created by moizhassankh on 29/01/24.
//

import Foundation

public struct InternalSurveyModel: Codable {
    var id: String
    var name: String
    var duration: Int
    var type: String
    var reward_id: String
    var questions_list: [String]
    var description: String
    var creation_date: String
    var expiry_date: String
    var organization_id: String
    var organization_name: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case duration
        case type
        case reward_id
        case questions_list
        case description
        case creation_date
        case expiry_date
        case organization_id
        case organization_name
    }

    public init(
        id: String,
        name: String = "",
        duration: Int = 0,
        type: String = "",
        reward_id: String = "",
        questions_list: [String] = [],
        description: String = "",
        creation_date: String = "",
        expiry_date: String = "",
        organization_id: String = "",
        organization_name: String = ""
    ) {
        self.id = id
        self.name = name
        self.duration = duration
        self.type = type
        self.reward_id = reward_id
        self.questions_list = questions_list
        self.description = description
        self.creation_date = creation_date
        self.expiry_date = expiry_date
        self.organization_id = organization_id
        self.organization_name = organization_name
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        duration = try container.decode(Int.self, forKey: .duration)
        type = try container.decode(String.self, forKey: .type)
        reward_id = try container.decode(String.self, forKey: .reward_id)
        questions_list = try container.decode([String].self, forKey: .questions_list)
        description = try container.decode(String.self, forKey: .description)
        creation_date = try container.decode(String.self, forKey: .creation_date)
        expiry_date = try container.decode(String.self, forKey: .expiry_date)
        organization_id = try container.decode(String.self, forKey: .organization_id)
        organization_name = try container.decode(String.self, forKey: .organization_name)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(duration, forKey: .duration)
        try container.encode(type, forKey: .type)
        try container.encode(reward_id, forKey: .reward_id)
        try container.encode(questions_list, forKey: .questions_list)
        try container.encode(description, forKey: .description)
        try container.encode(creation_date, forKey: .creation_date)
        try container.encode(expiry_date, forKey: .expiry_date)
        try container.encode(organization_id, forKey: .organization_id)
        try container.encode(organization_name, forKey: .organization_name)
    }
}
