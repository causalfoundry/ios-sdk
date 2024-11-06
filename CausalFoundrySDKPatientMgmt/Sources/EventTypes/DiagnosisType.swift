//
//  DiagnosisType.swift
//
//
//  Created by khushbu on 03/11/23.
//

import CausalFoundrySDKCore
import Foundation

public enum DiagnosisType: String, EnumComposable {
    case Bio
    case HIV
    case NCD
    case TB
    case ECD
    case Diabetes
    case Hypertension
    case Pregnancy
    case MentalHealth
    case SubstanceUseDisorder
    case AdolescentHealth
    case GeneralScreening
    case Gynecologic
    case Antenatal
    case Postnatal
    case CervicalCancer
    case Lifestyle
    case Psychological
    case GenderBasedViolence
    case SexualBehaviour
    case EconomicStrength
    case Other
    
    
    public var rawValue: String {
        switch self {
        case .Bio: return "bio"
        case .HIV: return "hiv"
        case .NCD: return "ncd"
        case .TB: return "tb"
        case .ECD: return "ecd"
        case .Diabetes: return "diabetes"
        case .Hypertension: return "hypertension"
        case .Pregnancy: return "pregnancy"
        case .MentalHealth: return "mental_health"
        case .SubstanceUseDisorder: return "substance_use_disorder"
        case .AdolescentHealth: return "adolescent_health"
        case .GeneralScreening: return "general_screening"
        case .Gynecologic: return "gynecologic"
        case .Antenatal: return "antenatal"
        case .Postnatal: return "postnatal"
        case .CervicalCancer: return "cervical_cancer"
        case .Lifestyle: return "lifestyle"
        case .Psychological: return "psychological"
        case .GenderBasedViolence: return "gender_based_violence"
        case .SexualBehaviour: return "sexual_behaviour"
        case .EconomicStrength: return "economic_strengthening"
        case .Other: return "other"
        }
    }
    
}
