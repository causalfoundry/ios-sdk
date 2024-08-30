//
//  DiagnosisQuestionItem.swift
//
//
//  Created by MOIZ HASSAN KHAN on 30/4/24.
//

import Foundation

public struct DiagnosisQuestionItem: Codable {
    var type: String
    var question: String
    var reply: String
    var score: Float?
    var fullScore: Float?
    var section: String?
    var remarks: String?

    enum CodingKeys: String, CodingKey {
        case type
        case question
        case reply
        case score
        case fullScore = "full_score"
        case section
        case remarks
    }

    public init(type: String, question: String, reply: String, score: Float? = nil, fullScore: Float? = nil, section: String? = nil, remarks: String? = nil) {
        self.type = type
        self.question = question
        self.reply = reply
        self.score = score
        self.fullScore = fullScore
        self.section = section
        self.remarks = remarks
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decode(String.self, forKey: .type)
        question = try container.decode(String.self, forKey: .question)
        reply = try container.decode(String.self, forKey: .reply)
        score = try container.decodeIfPresent(Float.self, forKey: .score)
        fullScore = try container.decodeIfPresent(Float.self, forKey: .fullScore)
        section = try container.decodeIfPresent(String.self, forKey: .section)
        remarks = try container.decodeIfPresent(String.self, forKey: .remarks)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type, forKey: .type)
        try container.encode(question, forKey: .question)
        try container.encode(reply, forKey: .reply)
        try container.encodeIfPresent(score, forKey: .score)
        try container.encodeIfPresent(fullScore, forKey: .fullScore)
        try container.encodeIfPresent(section, forKey: .section)
        try container.encodeIfPresent(remarks, forKey: .remarks)
    }
}

