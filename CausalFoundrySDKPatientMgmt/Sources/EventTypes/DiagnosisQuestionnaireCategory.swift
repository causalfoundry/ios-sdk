//
//  File.swift
//  
//
//  Created by MOIZ HASSAN KHAN on 2/9/24.
//

import CausalFoundrySDKCore
import Foundation

public enum DiagnosisQuestionnaireCategory: String, EnumComposable {
    case MedicalReview
    case Assessment
    case Diagnostic
    case Other
    
    public var rawValue: String {
        switch self {
        case .MedicalReview: return "medical_review"
        case .Assessment: return "assessment"
        case .Diagnostic: return "diagnostic"
        case .Other: return "other"
        }
    }
    
}
