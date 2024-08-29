//
//  File.swift
//  
//
//  Created by MOIZ HASSAN KHAN on 29/8/24.
//

import Foundation

public enum PatientMgmtCatalogSubject: String, CaseIterable, Codable {
    case UserHcw
    case HcwSite
    case Patient
    
    public var rawValue: String {
        switch self {
        case .UserHcw: return "user_chw"
        case .HcwSite: return "chwsite"
        case .Patient: return "patient"
        }
    }
    
}
