//
//  SubscriptionStatus.swift
//
//
//  Created by MOIZ HASSAN KHAN on 26/4/24.
//

import CausalFoundrySDKCore
import Foundation


public enum SubscriptionStatus: String, EnumComposable {
    case Active
    case Inactive
    case Paused
    case Other
    
    public var rawValue: String {
        switch self {
        case .Active: return "active"
        case .Inactive: return "inactive"
        case .Paused: return "paused"
        case .Other: return "other"
        }
    }
}
