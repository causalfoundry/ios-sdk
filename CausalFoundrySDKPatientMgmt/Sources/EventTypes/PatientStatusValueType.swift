//
//  PatientStatusValueType.swift
//
//
//  Created by khushbu on 04/11/23.
//

import CausalFoundrySDKCore
import Foundation

public enum PatientStatusValueType: String, EnumComposable {
    case NA
    case NewPatient
    case KnownPatient
    case Other
    
    
    public var rawValue: String {
        switch self {
        case .NA: return "n_a"
        case .NewPatient: return "new_patient"
        case .KnownPatient: return "known_patient"
        case .Other: return "other"
        }
    }
    
}
