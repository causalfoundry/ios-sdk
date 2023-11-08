//
//  SurveyEventObject.swift
//
//
//  Created by khushbu on 08/11/23.
//

import Foundation


public  struct SurveyEventObject: Codable {
    var action: String
    var survey: SurveyObject
    var response: [SurveyResponseItem]
    var meta: Encodable?
    
    enum CodingKeys: String, CodingKey {
        case action
        case survey
        case response
        case meta
    }
    
    public init(action: String, survey: SurveyObject, response: [SurveyResponseItem] = [], meta: Encodable? = nil) {
        self.action = action
        self.survey = survey
        self.response = response
        self.meta = meta
    }
    
    public  init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        action = try container.decode(String.self, forKey: .action)
        survey = try container.decode(SurveyObject.self, forKey: .survey)
        response = try container.decode([SurveyResponseItem].self, forKey: .response)
        
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
        try container.encode(response, forKey: .response)
        if let metaData = meta {
            try container.encode(metaData, forKey: .meta)
        }
        
    }
}
