//
//  File.swift
//  
//
//  Created by MOIZ HASSAN KHAN on 30/8/24.
//

import Foundation
import CausalFoundrySDKCore

public enum PatientType: String, EnumComposable {
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
