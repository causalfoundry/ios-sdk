//
//  File.swift
//  
//
//  Created by MOIZ HASSAN KHAN on 30/8/24.
//

import Foundation
import KenkaiSDKCore

public enum DiagnosisSubType: String, EnumComposable {
    case Age
    case Gender
    case Height
    case Weight
    case Smoker
    case BloodPressure
    case BloodGlucose
    case HbA1c
    case Temperature
    case Bmi
    case Cvd
    case Phq4
    case Phq9
    case Gad7
    case PregnancyStatus
    case PregnancyDangerSigns
    case SuicidalIdeation
    case HighRiskPregnancy
    case Other
    
    
    public var rawValue: String {
        switch self {
        case .Age: return "age"
        case .Gender: return "gender"
        case .Height: return "height"
        case .Weight: return "weight"
        case .Smoker: return "smoker"
        case .BloodPressure: return "blood_pressure"
        case .BloodGlucose: return "blood_glucose"
        case .HbA1c: return "hbA1c"
        case .Temperature: return "temperature"
        case .Bmi: return "bmi"
        case .Cvd: return "cvd"
        case .Phq4: return "phq_4"
        case .Phq9: return "phq_9"
        case .Gad7: return "gad_7"
        case .PregnancyStatus: return "pregnancy_status"
        case .PregnancyDangerSigns: return "pregnancy_danger_signs"
        case .SuicidalIdeation: return "suicidal_ideation"
        case .HighRiskPregnancy: return "high_risk_pregnancy"
        case .Other: return "other"
        }
    }
    
}
