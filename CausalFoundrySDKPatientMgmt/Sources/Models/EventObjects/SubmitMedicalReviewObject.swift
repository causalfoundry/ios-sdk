//
//  SubmitMedicalReviewObject.swift
//
//
//  Created by khushbu on 07/11/23.
//

import Foundation

public struct SubmitMedicalReviewObject: Codable {
    let patientId: String
    let siteId: String
    let medicalReview: MedicalReviewObject
    let meta: Encodable?

    enum CodingKeys: String, CodingKey {
        case patientId = "patient_id"
        case siteId = "site_id"
        case medicalReview = "medical_review"
        case meta
    }

    public init(patientId: String, siteId: String, medicalReview: MedicalReviewObject, meta: Encodable? = nil) {
        self.patientId = patientId
        self.siteId = siteId
        self.medicalReview = medicalReview
        self.meta = meta
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        patientId = try container.decode(String.self, forKey: .patientId)
        siteId = try container.decode(String.self, forKey: .siteId)
        medicalReview = try container.decode(MedicalReviewObject.self, forKey: .medicalReview)
        if let metaData = try container.decodeIfPresent(Data.self, forKey: .meta) {
            meta = try? (JSONSerialization.jsonObject(with: metaData, options: .allowFragments) as! any Encodable)
        } else {
            meta = nil
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(patientId, forKey: .patientId)
        try container.encode(siteId, forKey: .siteId)
        try container.encode(medicalReview, forKey: .medicalReview)
        if let metaData = meta {
            try container.encode(metaData, forKey: .meta)
        }
    }
}
