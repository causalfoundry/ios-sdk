//
//  DiagnosisQuestionnaireType.swift
//
//
//  Created by MOIZ HASSAN KHAN on 26/4/24.
//

import CausalFoundrySDKCore
import Foundation

public enum DiagnosisQuestionnaireType: String, EnumComposable {
    case Phq4
    case CageAid
    case SuicidalIdeation
    case SubstanceAbuse
    case Phq9
    case Gad7
    case Pregnancy
    case Diabetes
    case Hypertension
    case MentalHealth
    case MaternalHealth
    case Other
    
    public var rawValue: String {
        switch self {
        case .Phq4: return "phq_4"
        case .CageAid: return "cage_aid"
        case .SuicidalIdeation: return "suicidal_ideation"
        case .SubstanceAbuse: return "substance_abuse"
        case .Phq9: return "phq_9"
        case .Gad7: return "gad_7"
        case .Pregnancy: return "pregnancy"
        case .Diabetes: return "diabetes"
        case .Hypertension: return "hypertension"
        case .MentalHealth: return "mental_health"
        case .MaternalHealth: return "maternal_health"
        case .Other: return "other"
        }
    }
    
}
