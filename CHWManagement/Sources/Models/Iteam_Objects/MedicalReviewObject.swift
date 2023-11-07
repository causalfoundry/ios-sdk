//
//  File 2.swift
//  
//
//  Created by khushbu on 07/11/23.
//

import Foundation

public struct MedicalReviewObject: Codable {
    let id: String?
    var reviewSummaryList: [MedicalReviewSummaryObject]?

    enum CodingKeys: String, CodingKey {
        case id
        case reviewSummaryList = "review_summary_list"
    }

    public init(id: String, reviewSummaryList: [MedicalReviewSummaryObject] = []) {
        self.id = id
        self.reviewSummaryList = reviewSummaryList
    }

    public  init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        reviewSummaryList = try container.decode([MedicalReviewSummaryObject].self, forKey: .reviewSummaryList)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(reviewSummaryList, forKey: .reviewSummaryList)
    }
}
