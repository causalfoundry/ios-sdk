//
//  SurveyEventObject.swift
//
//
//  Created by khushbu on 08/11/23.
//

import Foundation

public struct SurveyEventObject: Codable {
    var action: String
    var surveyId: String
    var surveyType: String
    var isCompleted: Bool = false
    var rewardId: String?
    var surveyQuestions: [String]
    var responseList: [String]
    var meta: Encodable?

    private enum CodingKeys: String, CodingKey {
        case action
        case id
        case type
        case isCompleted = "is_completed"
        case rewardId = "reward_id"
        case surveyQuestions = "survey_questions"
        case responseList = "response_list"
        case meta
    }

    public init(action: SurveyAction, surveyId: String, surveyType: SurveyType, isCompleted: Bool, rewardId: String?, surveyQuestions: [String]?, responseList: [String]?, meta: Encodable? = nil) {
        self.action = action.rawValue
        self.surveyId = surveyId
        self.surveyType = surveyType.rawValue
        self.isCompleted = isCompleted
        self.rewardId = rewardId
        self.surveyQuestions = surveyQuestions ?? []
        self.responseList = responseList ?? []
        self.meta = meta
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        action = try container.decode(String.self, forKey: .action)
        surveyId = try container.decode(String.self, forKey: .id)
        surveyType = try container.decode(String.self, forKey: .type)
        isCompleted = try container.decode(Bool.self, forKey: .isCompleted)
        rewardId = try container.decodeIfPresent(String.self, forKey: .rewardId)
        surveyQuestions = try container.decodeIfPresent([String].self, forKey: .surveyQuestions) ?? []
        responseList = try container.decodeIfPresent([String].self, forKey: .responseList) ?? []

        if let metaData = try container.decodeIfPresent(Data.self, forKey: .meta) {
            meta = try? (JSONSerialization.jsonObject(with: metaData, options: .allowFragments) as! any Encodable)
        } else {
            meta = nil
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(action, forKey: .action)
        try container.encode(surveyId, forKey: .id)
        try container.encode(surveyType, forKey: .type)
        try container.encode(isCompleted, forKey: .isCompleted)
        try container.encodeIfPresent(rewardId, forKey: .rewardId)
        try container.encodeIfPresent(surveyQuestions, forKey: .surveyQuestions)
        try container.encodeIfPresent(responseList, forKey: .responseList)
        if let metaData = meta {
            try container.encode(metaData, forKey: .meta)
        }
    }
}
