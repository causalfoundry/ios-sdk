//
//  DiagnosisSymptomType.swift
//
//
//  Created by khushbu on 03/11/23.
//

import CausalFoundrySDKCore
import Foundation

public enum DiagnosisSymptomType: String, EnumComposable {
    case Diabetes
    case Hypertension
    case Pregnancy
    case MentalHealth
    case SubstanceUseDisorder
    case Other
    
    public var rawValue: String {
        switch self {
        case .Diabetes: return "diabetes"
        case .Hypertension: return "hypertension"
        case .Pregnancy: return "pregnancy"
        case .MentalHealth: return "mental_health"
        case .SubstanceUseDisorder: return "substance_use_disorder"
        case .Other: return "other"
        }
    }
    
}
