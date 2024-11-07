//
//  ImmunizationItem.swift
//  CausalFoundrySDK
//
//  Created by MOIZ HASSAN KHAN on 6/11/24.
//

import Foundation

public struct ImmunizationItem: Codable {
    var id: String
    var action: String
    var type: String
    var dose: Int
    var status: Bool
    var date: Int64?
    var remarks: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case action
        case type
        case dose
        case status
        case date
        case remarks
    }
    
    public init(id: String, action: String, type: String, dose: Int, status: Bool, date: Int64? = nil, remarks: String? = nil) {
        self.id = id
        self.action = action
        self.type = type
        self.dose = dose
        self.status = status
        self.date = date
        self.remarks = remarks
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        action = try container.decode(String.self, forKey: .action)
        type = try container.decode(String.self, forKey: .type)
        dose = try container.decode(Int.self, forKey: .dose)
        status = try container.decode(Bool.self, forKey: .status)
        date = try container.decodeIfPresent(Int64.self, forKey: .date)
        remarks = try container.decodeIfPresent(String.self, forKey: .remarks)
        
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(action, forKey: .action)
        try container.encode(type, forKey: .type)
        try container.encode(dose, forKey: .dose)
        try container.encode(status, forKey: .status)
        try container.encodeIfPresent(date, forKey: .date)
        try container.encodeIfPresent(remarks, forKey: .remarks)
        
    }
}


