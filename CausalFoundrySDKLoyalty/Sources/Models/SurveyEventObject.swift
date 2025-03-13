//
//  SurveyEventObject.swift
//
//
//  Created by khushbu on 08/11/23.
//

import Foundation

public struct SurveyEventObject: Codable {
    var action: String
    var survey: SurveyObject
    var responseList: [SurveyResponseItem]
    var meta: Encodable?

    private enum CodingKeys: String, CodingKey {
        case action
        case survey
        case responseList = "response"
        case meta
    }

    public init(action: SurveyAction, survey: SurveyObject, responseList: [SurveyResponseItem] = [], meta: Encodable? = nil) {
        self.action = action.rawValue
        self.survey = survey
        self.responseList = responseList
        self.meta = meta
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        action = try container.decode(String.self, forKey: .action)
        survey = try container.decode(SurveyObject.self, forKey: .survey)
        responseList = try container.decode([SurveyResponseItem].self, forKey: .responseList)

        if let metaData = try container.decodeIfPresent(Data.self, forKey: .meta) {
            meta = try? (JSONSerialization.jsonObject(with: metaData, options: .allowFragments) as! any Encodable)
        } else {
            meta = nil
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(action, forKey: .action)
        try container.encode(survey, forKey: .survey)
        try container.encode(responseList, forKey: .responseList)
        if let metaData = meta {
            try container.encode(metaData, forKey: .meta)
        }
    }
}
