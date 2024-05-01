//
//  DiagnosisQuestionnaireObject.swift
//
//
//  Created by MOIZ HASSAN KHAN on 30/4/24.
//

import Foundation

public struct DiagnosisQuestionnaireObject: Codable {
    var type: String
    var questions: [DiagnosisQuestionItem]
    var instructions: String?

    enum CodingKeys: String, CodingKey {
        case type
        case questions
        case instructions
    }

    public init(type: String, questions: [DiagnosisQuestionItem], instructions: String? = nil) {
        self.type = type
        self.questions = questions
        self.instructions = instructions
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decode(String.self, forKey: .type)
        questions = try container.decode([DiagnosisQuestionItem].self, forKey: .questions)
        instructions = try container.decodeIfPresent(String.self, forKey: .instructions)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type, forKey: .type)
        try container.encode(questions, forKey: .questions)
        try container.encodeIfPresent(instructions, forKey: .instructions)
    }
}
