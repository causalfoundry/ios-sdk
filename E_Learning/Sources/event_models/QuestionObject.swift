//
//  QuestionObject.swift
//
//
//  Created by khushbu on 02/11/23.
//

import Foundation

struct QuestionObject: Codable {
    var id: String
    var exam_id: String
    var action: String
    var answer_id: String?
    var meta: Encodable?
    
    enum CodingKeys: String, CodingKey {
        case id
        case exam_id
        case action
        case answer_id
        case meta¯
    }
    
    init(id: String, exam_id: String, action: String, answer_id: String? = nil, meta: Encodable? = nil) {
        self.id = id
        self.exam_id = exam_id
        self.action = action
        self.answer_id = answer_id
        self.meta = meta
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        exam_id = try container.decode(String.self, forKey: .exam_id)
        action = try container.decode(String.self, forKey: .action)
        answer_id = try container.decodeIfPresent(String.self, forKey: .answer_id)
        if let metaData = try container.decodeIfPresent(Data.self, forKey:.meta¯) {
            meta = try? (JSONSerialization.jsonObject(with: metaData, options: .allowFragments) as! any Encodable)
        } else {
            meta = nil
        }
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(exam_id, forKey: .exam_id)
        try container.encode(action, forKey: .action)
        try container.encodeIfPresent(answer_id, forKey: .answer_id)
        if let metaData = meta {
            try container.encode(metaData, forKey: .meta¯)
        }
    }
}
