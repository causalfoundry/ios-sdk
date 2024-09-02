//
//  File.swift
//  
//
//  Created by MOIZ HASSAN KHAN on 27/8/24.
//

import Foundation

public enum CoreCatalogSubject: String, CaseIterable, Codable {
    case User
    case Media
    
    public var rawValue: String {
        switch self {
        case .User: return "user"
        case .Media: return "media"
        }
    }
    
}
