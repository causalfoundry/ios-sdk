//
//  EComEventType.swift
//
//
//  Created by khushbu on 27/10/23.
//

import Foundation

public enum LoyaltyCatalogType: String, CaseIterable, Codable {
    case Survey
    case Reward
    
    public var rawValue: String {
        switch self {
        case .Survey: return "survey"
        case .Reward: return "reward"
        }
    }
    
}
