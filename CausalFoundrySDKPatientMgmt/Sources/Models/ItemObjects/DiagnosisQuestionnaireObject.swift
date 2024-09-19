//
//  DiagnosisQuestionnaireObject.swift
//
//
//  Created by MOIZ HASSAN KHAN on 30/4/24.
//

import Foundation

public struct DiagnosisQuestionnaireObject: Codable {
    var type: String
    var subType: String
    var category: String
    var questionList: [DiagnosisQuestionItem]
    var outcomeList: [DiagnosisOutcomeItem]
    var remarks: String?

    enum CodingKeys: String, CodingKey {
        case type
        case subType = "sub_type"
        case category = "category"
        case questionList = "question_list"
        case outcomeList = "outcome_list"
        case remarks
    }

    public init(type: String, subType: String, category: String, questionList: [DiagnosisQuestionItem], outcomeList: [DiagnosisOutcomeItem], remarks: String? = nil) {
        self.type = type
        self.subType = subType
        self.category = category
        self.questionList = questionList
        self.outcomeList = outcomeList
        self.remarks = remarks
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decode(String.self, forKey: .type)
        subType = try container.decode(String.self, forKey: .subType)
        category = try container.decode(String.self, forKey: .category)
        questionList = try container.decode([DiagnosisQuestionItem].self, forKey: .questionList)
        outcomeList = try container.decode([DiagnosisOutcomeItem].self, forKey: .outcomeList)
        remarks = try container.decodeIfPresent(String.self, forKey: .remarks)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type, forKey: .type)
        try container.encode(subType, forKey: .subType)
        try container.encode(category, forKey: .category)
        try container.encode(questionList, forKey: .questionList)
        try container.encode(outcomeList, forKey: .outcomeList)
        try container.encodeIfPresent(remarks, forKey: .remarks)
    }
}
