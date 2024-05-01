//
//  ReviewSummaryItem.swift
//
//
//  Created by khushbu on 07/11/23.
//

import CausalFoundrySDKCore
import Foundation

public enum ReviewSummaryItem: String, EnumComposable {
    case ChiefComplaints
    case PhysicalExaminations
    case Comorbidities
    case Complications
    case ObstetricExamination
    case SystemicExamination
    case Other
    
    
    public var rawValue: String {
        switch self {
        case .ChiefComplaints: return "chief_complaints"
        case .PhysicalExaminations: return "physical_examinations"
        case .Comorbidities: return "comorbidities"
        case .Complications: return "complications"
        case .ObstetricExamination: return "obstetric_examination"
        case .SystemicExamination: return "systemic_examination"
        case .Other: return "other"
        }
    }
}
