//
//  RewardAction.swift
//
//
//  Created by khushbu on 07/11/23.
//

import CausalFoundrySDKCore
import Foundation

public enum RewardAction: String, EnumComposable {
    case View
    case Add
    case Redeem
    case Other
    
    public var rawValue: String {
        switch self {
        case .View: return "view"
        case .Add: return "add"
        case .Redeem: return "redeem"
        case .Other: return "other"
        }
    }
    
}
