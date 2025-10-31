//
//  PatientMgmtEventType.swift
//
//
//  Created by khushbu on 25/10/23.
//

import Foundation

public enum PatientMgmtEventType: String, CaseIterable {
    
    case Patient
    case Encounter
    case Appointment
    case Diagnosis
    

    public var rawValue: String {
        switch self {
        case .Patient: return "patient"
        case .Encounter: return "encounter"
        case .Appointment: return "appointment"
        case .Diagnosis: return "diagnosis"
        }
    }
}
