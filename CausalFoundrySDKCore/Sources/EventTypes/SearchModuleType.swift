//
//  SearchModuleType.swift
//
//
//  Created by khushbu on 16/10/23.
//

import Foundation

public enum SearchModuleType: String, EnumComposable {
    case Core
    case ECommerce
    case ELearning
    case Screening
    case Assessment
    case Enrolment
    case MedicalReview
    case MyPatients
    case Prescription
    case LifestyleMgmt
    case PsychologicalMgmt
    case CounselingMgmt
    case Investigation
    case TreatmentPlan
    case Transfers
    case Other
    
    public var rawValue: String {
        switch self {
        case .Core: return "core"
        case .ECommerce: return "e_commerce"
        case .ELearning: return "e_learning"
        case .Screening: return "screening"
        case .Assessment: return "assessment"
        case .Enrolment: return "enrolment"
        case .MedicalReview: return "medical_review"
        case .MyPatients: return "my_patients"
        case .Prescription: return "prescription"
        case .LifestyleMgmt: return "lifestyle_mgmt"
        case .PsychologicalMgmt: return "psychological_mgmt"
        case .CounselingMgmt: return "counseling_mgmt"
        case .Investigation: return "investigation"
        case .TreatmentPlan: return "treatment_plan"
        case .Transfers: return "transfers"
        case .Other: return "other"
        }
    }
}
