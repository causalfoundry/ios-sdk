//
//  PrescriptionEventObject.swift
//
//
//  Created by khushbu on 03/11/23.
//

import Foundation


public struct PrescriptionEventObject: Codable {
    var patientId: String
    var siteId: String
    var prescriptionId: String
    var prescriptionList: [PrescriptionItem]
    var meta: Encodable?
    
    private enum CodingKeys: String, CodingKey {
        case patientId = "patient_id"
        case siteId = "site_id"
        case prescriptionId = "id"
        case prescriptionList = "prescription_list"
        case meta
    }
    
    init(patientId: String, siteId: String, prescriptionId: String, prescriptionList: [PrescriptionItem], meta: Encodable? = nil) {
        self.patientId = patientId
        self.siteId = siteId
        self.prescriptionId = prescriptionId
        self.prescriptionList = prescriptionList
        self.meta = meta
    }
    
    // Encode the struct to JSON data
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(patientId, forKey: .patientId)
        try container.encode(siteId, forKey: .siteId)
        try container.encode(prescriptionId, forKey: .prescriptionId)
        try container.encode(prescriptionList, forKey: .prescriptionList)
        if let metaData = meta {
            try container.encode(metaData, forKey: .meta)
        }
    }
    
    // Initialize a struct instance from decoded JSON data
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        patientId = try container.decode(String.self, forKey: .patientId)
        siteId = try container.decode(String.self, forKey: .siteId)
        prescriptionId = try container.decode(String.self, forKey: .prescriptionId)
        prescriptionList = try container.decode([PrescriptionItem].self, forKey: .prescriptionList)
        if let metaData = try container.decodeIfPresent(Data.self, forKey: .meta) {
            meta = try? (JSONSerialization.jsonObject(with: metaData, options: .allowFragments) as! any Encodable)
        } else {
            meta = nil
        }
        
    }
}

