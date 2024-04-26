//
//  PatientModuleType.swift
//
//
//  Created by khushbu on 26/10/23.
//

import CausalFoundrySDKCore
import Foundation

public enum PatientModuleType: String, EnumComposable {
    case Screening
    case Assessment
    case Enrolment
    case MedicalReview
    case MyPatients
    case Prescription
    case Transfers
    case LifestyleMgmt
    case PsychologicalMgmt
    case CounselingMgmt
    case Investigation
    case TreatmentPlan
    case Other
    
    
    public var rawValue: String {
        switch self {
        case .Screening: return "screening"
        case .Assessment: return "assessment"
        case .Enrolment: return "enrolment"
        case .MedicalReview: return "medical_review"
        case .MyPatients: return "my_patients"
        case .Prescription: return "prescription"
        case .Transfers: return "transfers"
        case .LifestyleMgmt: return "lifestyle_mgmt"
        case .PsychologicalMgmt: return "psychological_mgmt"
        case .CounselingMgmt: return "counseling_mgmt"
        case .Investigation: return "investigation"
        case .TreatmentPlan: return "treatment_plan"
        case .Other: return "other"
        }
    }
    
}
