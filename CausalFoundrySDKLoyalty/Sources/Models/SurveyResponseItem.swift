//
//  SurveyResponseItem.swift
//
//
//  Created by khushbu on 08/11/23.
//

import Foundation

public struct SurveyResponseItem: Codable {
    var id: String
    var question: String
    var response: String
    var type: String

    private enum CodingKeys: String, CodingKey {
        case id
        case question
        case response
        case type
    }

    public init(id: String, question: String, response: String, type: SurveyType) {
        self.id = id
        self.question = question
        self.response = response
        self.type = type.rawValue
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        question = try container.decode(String.self, forKey: .question)
        response = try container.decode(String.self, forKey: .response)
        type = try container.decode(String.self, forKey: .type)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(question, forKey: .question)
        try container.encode(response, forKey: .response)
        try container.encode(type, forKey: .type)
    }
}
