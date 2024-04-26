//
//  TreatmentType.swift
//
//
//  Created by khushbu on 04/11/23.
//

import CausalFoundrySDKCore
import Foundation

public enum TreatmentType: String, EnumComposable {
    case MedicalReview
    case BloodPressure
    case BloodGlucose
    case HbA1c
    case Cho
    case Other
    
    public var rawValue: String {
        switch self {
        case .MedicalReview: return "medical_review"
        case .BloodPressure: return "blood_pressure"
        case .BloodGlucose: return "blood_glucose"
        case .HbA1c: return "HbA1c"
        case .Cho: return "cho"
        case .Other: return "other"
        }
    }
    
}
