//
//  File.swift
//  
//
//  Created by MOIZ HASSAN KHAN on 2/9/24.
//
import KenkaiSDKCore
import Foundation

public enum EncounterType: String, EnumComposable {
    case Screening
    case Assessment
    case Enrolment
    case MedicalReview
    case Counseling
    case Other
    
    public var rawValue: String {
        switch self {
        case .Screening: return "screening"
        case .Assessment: return "assessment"
        case .Enrolment: return "enrolment"
        case .MedicalReview: return "medical_review"
        case .Counseling: return "counseling"
        case .Other: return "other"
        }
    }
    
}
