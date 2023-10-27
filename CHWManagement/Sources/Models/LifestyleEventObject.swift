//
//  LifestyleEventObject.swift
//
//
//  Created by khushbu on 26/10/23.
//

import Foundation

import Foundation

struct LifestyleEventObject: Codable {
    var patientId: String
    var siteId: String
    var lifestyleId: String
    var lifestylePlanList: [LifestylePlanItem]
    var meta: Any?
    
    init(patientId: String, siteId: String, lifestyleId: String, lifestylePlanList: [LifestylePlanItem], meta: Any? = nil) {
        self.patientId = patientId
        self.siteId = siteId
        self.lifestyleId = lifestyleId
        self.lifestylePlanList = lifestylePlanList
        self.meta = meta
    }
    
    private enum CodingKeys: String, CodingKey {
        case patientId = "patient_id"
        case siteId = "site_id"
        case lifestyleId = "id"
        case lifestylePlanList = "lifestyle_plan_list"
        case meta
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(patientId, forKey: .patientId)
        try container.encode(siteId, forKey: .siteId)
        try container.encode(lifestyleId, forKey: .lifestyleId)
        try container.encode(lifestylePlanList, forKey: .lifestylePlanList)
        if let meta = meta {
            if let intValue = meta as? Int {
                try container.encode(intValue, forKey: .meta)
            } else if let doubleValue = meta as? Double {
                try container.encode(doubleValue, forKey: .meta)
            } else if let stringValue = meta as? String {
                try container.encode(stringValue, forKey: .meta)
            }else if let boolValue = meta as? Bool {
                try container.encode(boolValue, forKey: .meta)
            }else if let dateValue = meta as? Date {
                try container.encode(dateValue, forKey: .meta)
            }
            
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        patientId = try container.decode(String.self, forKey: .patientId)
        siteId = try container.decode(String.self, forKey: .siteId)
        lifestyleId = try container.decode(String.self, forKey: .lifestyleId)
        lifestylePlanList = try container.decode([LifestylePlanItem].self, forKey: .lifestylePlanList)
        if let intValue = try? container.decode(Int.self, forKey: .meta) {
            meta = intValue
        } else if let doubleValue = try? container.decode(Double.self, forKey: .meta) {
            meta = doubleValue
        } else if let stringValue = try? container.decode(String.self, forKey: .meta) {
            meta = stringValue
        }
        else if let boolValue = try? container.decode(Bool.self, forKey: .meta) {
            meta = boolValue
        }
        else if let dateValue = try? container.decode(Date.self, forKey: .meta) {
            meta = dateValue
        }
    }
}
