//
//  File.swift
//
//
//  Created by khushbu on 21/11/23.
//

import Foundation


public struct CounselingEventObject: Codable {
    
    var patientId: String
    var siteId: String
    var counselingId: String
    var counselingType: String
    var counselingPlanList: [CounselingPlanItem]
    var meta: Encodable?
    
    enum CodingKeys: String, CodingKey {
        case patientId = "patient_id"
        case siteId = "site_id"
        case counselingId = "id"
        case counselingType = "counseling_type"
        case counselingPlanList = "counseling_plan_list"
        case meta
    }
    
    init(patientId: String, siteId: String, counselingId: String, counselingType: String, counselingPlanList: [CounselingPlanItem], meta: Encodable? = nil) {
        self.patientId = patientId
        self.siteId = siteId
        self.counselingId = counselingId
        self.counselingType = counselingType
        self.counselingPlanList = counselingPlanList
        self.meta = meta
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        patientId = try container.decode(String.self, forKey: .patientId)
        siteId = try container.decode(String.self, forKey: .siteId)
        counselingId = try container.decode(String.self, forKey: .counselingId)
        counselingType = try container.decode(String.self, forKey: .counselingType)
        counselingPlanList = try container.decode([CounselingPlanItem].self, forKey: .counselingPlanList)
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
        try container.encode(counselingId, forKey: .counselingId)
        try container.encode(counselingType, forKey: .counselingType)
        try container.encode(counselingPlanList, forKey: .counselingPlanList)
        if let metaData = meta {
            try container.encode(metaData, forKey: .meta)
        }
        
    }
}


