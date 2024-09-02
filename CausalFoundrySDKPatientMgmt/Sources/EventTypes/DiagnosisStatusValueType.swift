//
//  File.swift
//  
//
//  Created by MOIZ HASSAN KHAN on 2/9/24.
//

import CausalFoundrySDKCore
import Foundation

public enum DiagnosisStatusValueType: String, EnumComposable {
    case HighRisk
    case NotHighRisk
    case NA
    case NewPatient
    case KnownPatient
    case Other
    
    public var rawValue: String {
        switch self {
        case .HighRisk: return "high_risk"
        case .NotHighRisk: return "not_high_risk"
        case .NA: return "n_a"
        case .NewPatient: return "new_patient"
        case .KnownPatient: return "known_patient"
        case .Other: return "other"
        }
    }
    
}
