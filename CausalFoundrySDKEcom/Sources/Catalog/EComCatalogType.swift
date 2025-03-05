//
//  EComEventType.swift
//
//
//  Created by khushbu on 27/10/23.
//

import Foundation

public enum EComCatalogType: String, CaseIterable, Codable {
    case Drug
    case Grocery
    case Blood
    case Oxygen
    case MedicalEquipment
    case Facility
    
    public var rawValue: String {
        switch self {
        case .Drug: return "drug"
        case .Grocery: return "grocery"
        case .Blood: return "blood"
        case .Oxygen: return "oxygen"
        case .MedicalEquipment: return "medical_equipment"
        case .Facility: return "facility"
        }
    }
    
}
