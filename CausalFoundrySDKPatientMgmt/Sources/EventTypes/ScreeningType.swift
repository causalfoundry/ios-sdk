//
//  ScreeningType.swift
//
//
//  Created by khushbu on 07/11/23.
//

import CausalFoundrySDKCore
import Foundation

public enum ScreeningType: String, EnumComposable {
    case Triage
    case Outpatient
    case Inpatient
    case Pharmacy
    case DoorToDoor
    case Camp
    case Other
    
    
    public var rawValue: String {
        switch self {
        case .Triage: return "triage"
        case .Outpatient: return "outpatient"
        case .Inpatient: return "inpatient"
        case .Pharmacy: return "pharmacy"
        case .DoorToDoor: return "door_to_door"
        case .Camp: return "camp"
        case .Other: return "other"
        }
    }
    
}
