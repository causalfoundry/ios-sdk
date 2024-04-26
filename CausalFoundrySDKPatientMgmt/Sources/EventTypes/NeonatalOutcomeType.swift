//
//  NeonatalOutcomeType.swift
//
//
//  Created by MOIZ HASSAN KHAN on 26/4/24.
//

import CausalFoundrySDKCore
import Foundation

public enum NeonatalOutcomeType: String, EnumComposable {
    case StillBirth
    case LiveBirth
    case NeonatalDeath
    case Other

    
    public var rawValue: String {
        switch self {
        case .StillBirth: return "still_birth"
        case .LiveBirth: return "live_birth"
        case .NeonatalDeath: return "neonatal_death"
        case .Other: return "other"
        }
    }
}
