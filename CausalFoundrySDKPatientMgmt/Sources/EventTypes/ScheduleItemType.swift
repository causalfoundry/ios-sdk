//
//  File.swift
//  
//
//  Created by MOIZ HASSAN KHAN on 2/9/24.
//

import CausalFoundrySDKCore
import Foundation

public enum ScheduleItemType: String, EnumComposable {
    case MedicalReview
    case Assessment
    case Other
    
    public var rawValue: String {
        switch self {
        case .MedicalReview: return "medical_review"
        case .Assessment: return "assessment"
        case .Other: return "other"
        }
    }
    
}
