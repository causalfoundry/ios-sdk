//
//  File.swift
//  
//
//  Created by MOIZ HASSAN KHAN on 29/8/24.
//

import Foundation

public enum PatientMgmtCatalogType: String, CaseIterable, Codable {
    case UserHcw
    case Patient
    
    public var rawValue: String {
        switch self {
        case .UserHcw: return "user_chw"
        case .Patient: return "patient"
        }
    }
    
}
