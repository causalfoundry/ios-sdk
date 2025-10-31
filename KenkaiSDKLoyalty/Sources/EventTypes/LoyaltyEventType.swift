//
//  LoyaltyEventType.swift
//
//
//  Created by khushbu on 07/11/23.
//

import Foundation

public enum LoyaltyEventType: String, CaseIterable, Codable {
    case Level
    case Milestone
    case Promo
    case Survey
    case Reward
    
    public var rawValue: String {
        switch self {
        case .Level: return "level"
        case .Milestone: return "milestone"
        case .Promo: return "promo"
        case .Survey: return "survey"
        case .Reward: return "reward"
        }
    }
    
}
