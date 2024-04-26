//
//  MaternalOutcomeType.swift
//  
//
//  Created by MOIZ HASSAN KHAN on 26/4/24.
//

import CausalFoundrySDKCore
import Foundation

public enum MaternalOutcomeType: String, EnumComposable {
    case AliveWell
    case MaternalDeath
    case Other

    
    public var rawValue: String {
        switch self {
        case .AliveWell: return "alive_well"
        case .MaternalDeath: return "maternal_death"
        case .Other: return "other"
        }
    }
}
