//
//  QuestionObject.swift
//
//
//  Created by moizhassankh on 04/01/24.
//

import Foundation

public struct QuestionObject: Codable {
    var id: String = ""
    var examId: String = ""
    var action: String = ""
    var answerId: String?
    var meta: Encodable?

    private enum CodingKeys: String, CodingKey {
        case id
        case examId = "exam_id"
        case action
        case answerId = "answer_id"
        case meta
    }

    public init(id: String, examId: String, action: QuestionAction, answerId: String? = nil, meta: Encodable? = nil) {
        self.id = id
        self.examId = examId
        self.action = action.rawValue
        self.answerId = answerId
        self.meta = meta
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(examId, forKey: .examId)
        try container.encode(action, forKey: .action)
        try container.encodeIfPresent(answerId, forKey: .answerId)
        if let metaData = meta {
            try container.encodeIfPresent(metaData, forKey: .meta)
        }
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        examId = try container.decode(String.self, forKey: .examId)
        action = try container.decode(String.self, forKey: .action)
        answerId = try container.decodeIfPresent(String.self, forKey: .answerId)
        if let metaData = try? container.decodeIfPresent(Data.self, forKey: .meta) {
            meta = try? (JSONSerialization.jsonObject(with: metaData, options: .allowFragments) as! any Encodable)
        } else {
            meta = nil
        }
    }
}
