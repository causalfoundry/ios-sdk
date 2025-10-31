//
//  File.swift
//  
//
//  Created by MOIZ HASSAN KHAN on 2/9/24.
//

import KenkaiSDKCore
import Foundation

public enum DiagnosisQuestionnaireOutcomeType: String, EnumComposable {
    case RiskStatus
    case RiskScore
    case Other
    
    public var rawValue: String {
        switch self {
        case .RiskStatus: return "risk_status"
        case .RiskScore: return "risk_score"
        case .Other: return "other"
        }
    }
    
}
