//
//  File.swift
//
//
//  Created by MOIZ HASSAN KHAN on 30/8/24.
//

import Foundation

public struct DiagnosisStatusItem: Codable {
    var type: String
    var subType: String
    var action: String
    var value: String
    var diagnosisDate: Int64
    var isConfirmed: Bool?
    var remarks: String?
    var stage: String?
    var treatmentStatus: String?
    
    enum CodingKeys: String, CodingKey {
        case type
        case subType = "sub_type"
        case action
        case value
        case diagnosisDate = "diagnosis_date"
        case isConfirmed = "is_confirmed"
        case remarks
        case stage
        case treatmentStatus = "treatment_status"
    }
    
    public init(type: String, subType: String, action: String, value: String, diagnosisDate: Int64, isConfirmed: Bool? = nil, remarks: String? = nil, stage: String? = nil, treatmentStatus: String? = nil) {
        self.type = type
        self.subType = subType
        self.action = action
        self.value = value
        self.diagnosisDate = diagnosisDate
        self.isConfirmed = isConfirmed
        self.remarks = remarks
        self.stage = stage
        self.treatmentStatus = treatmentStatus
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decode(String.self, forKey: .type)
        subType = try container.decode(String.self, forKey: .subType)
        action = try container.decode(String.self, forKey: .action)
        value = try container.decode(String.self, forKey: .value)
        diagnosisDate = try container.decode(Int64.self, forKey: .diagnosisDate)
        isConfirmed = try container.decodeIfPresent(Bool.self, forKey: .isConfirmed)
        remarks = try container.decodeIfPresent(String.self, forKey: .remarks)
        stage = try container.decodeIfPresent(String.self, forKey: .stage)
        treatmentStatus = try container.decodeIfPresent(String.self, forKey: .treatmentStatus)
        
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type, forKey: .type)
        try container.encode(subType, forKey: .subType)
        try container.encode(action, forKey: .action)
        try container.encode(value, forKey: .value)
        try container.encode(diagnosisDate, forKey: .diagnosisDate)
        try container.encodeIfPresent(isConfirmed, forKey: .isConfirmed)
        try container.encodeIfPresent(remarks, forKey: .remarks)
        try container.encodeIfPresent(stage, forKey: .stage)
        try container.encodeIfPresent(treatmentStatus, forKey: .treatmentStatus)
        
    }
}

